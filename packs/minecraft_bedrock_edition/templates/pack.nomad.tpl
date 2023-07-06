[[- $ports := .my.nomad_group_ports ]]

# see https://developer.hashicorp.com/nomad/docs/job-specification/job
job "[[ .my.nomad_job_name ]]" {
  region      = "[[ .my.nomad_job_region ]]"
  datacenters = [[ .my.nomad_job_datacenters | toJson ]]
  type        = "service"
  namespace   = "[[ .my.nomad_job_namespace ]]"
  priority    = [[ .my.nomad_priority ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/group
  group "[[ .my.nomad_group_name ]]" {
    count = [[ .my.nomad_group_count ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
    ephemeral_disk {
      [[- $ephemeral_disk := .my.ephemeral_disk ]]
      migrate = [[ $ephemeral_disk.migrate ]]
      size    = [[ $ephemeral_disk.size ]]
      sticky  = [[ $ephemeral_disk.sticky ]]
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/network
    network {
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
      mode = "[[ .my.nomad_group_network_mode ]]"

      [[/* iterate over `$ports` to create Port Mappings */]]
      [[- range $name, $config := $ports ]]
      port "[[ $name ]]" {
        static       = [[ $config.port ]]
        to           = [[ $config.port ]]
        [[- if $config.host_network ]]
        host_network = "[[ $config.host_network ]]"
        [[- end ]]
      }
      [[ end ]]
    }

    [[- $job_tags := .my.nomad_group_tags -]]
    [[- $service_name := .my.nomad_group_service_name_prefix -]]
    [[- $service_provider := .my.nomad_group_service_provider -]]
    [[/* iterate over `$ports` to map Services */]]
    [[ range $name, $port := $ports ]]
    # see https://developer.hashicorp.com/nomad/docs/job-specification/service
    service {
      name     = "[[ $service_name | replace "_" "-" | trunc 20 ]]-[[ $name | replace "_" "-" | trunc 43 ]]"
      tags     = [[ $job_tags | toJson ]]
      port     = [[ $port.port ]]
      provider = "[[ $service_provider ]]"

      # see https://developer.hashicorp.com/nomad/docs/job-specification/check
      check {
        name     = "[[ $name ]]"
        type     = "[[ $port.type ]]"
        [[- if eq $port.type "http" ]]
        path     = "[[ $port.path ]]"
        [[- end ]]
        interval = "[[ $port.check_interval ]]"
        timeout  = "[[ $port.check_timeout ]]"
      }
    }
    [[ end ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/restart
    restart {
      [[- $restart_logic := .my.nomad_group_restart_logic ]]
      attempts = [[ $restart_logic.attempts ]]
      interval = "[[ $restart_logic.interval ]]"
      delay    = "[[ $restart_logic.delay ]]"
      mode     = "[[ $restart_logic.mode ]]"
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/volume
    [[/* iterate over `var.volumes` to create Volumes */]]
    [[- range $index, $mount := .my.nomad_group_volumes ]]
    volume "[[ $mount.name ]]" {
      source    = "[[ $mount.name ]]"
      type      = "[[ $mount.type ]]"
      read_only = [[ $mount.read_only ]]
    }
    [[ end ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/task
    task "[[ .my.nomad_task_name ]]" {
      # see https://developer.hashicorp.com/nomad/docs/drivers
      driver = "[[ .my.nomad_task_driver ]]"

      # see https://developer.hashicorp.com/nomad/docs/drivers/docker
      # and https://developer.hashicorp.com/nomad/plugins/drivers/podman
      config {
        image = "[[ .my.nomad_task_image.registry ]]/[[ .my.nomad_task_image.namespace ]]/[[ .my.nomad_task_image.image ]]:[[ .my.nomad_task_image.tag ]]@[[ .my.nomad_task_image.digest ]]"

        # see https://developer.hashicorp.com/nomad/docs/drivers/docker#ports
        # and https://developer.hashicorp.com/nomad/plugins/drivers/podman#ports
        ports = [
          [[- range $name, $port := $ports ]]
          "[[ $name ]]",
          [[- end ]]
        ]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/env
      env {
        [[- template "configuration" . ]]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/volume_mount
      [[/* iterate over `var.volumes` to create Volume Mounts */]]
      [[- range $index, $mount := .my.nomad_group_volumes ]]
      volume_mount {
          volume      = "[[ $mount.name ]]"
          destination = "[[ $mount.destination ]]"
          read_only   = [[ $mount.read_only ]]
      }
      [[ end ]]

      # see https://developer.hashicorp.com/nomad/docs/job-specification/resources
      resources {
        [[- $resources := .my.nomad_task_resources ]]
        cpu        = [[ $resources.cpu ]]
        cores      = [[ $resources.cores | default "null" ]]
        memory     = [[ $resources.memory ]]

        # TODO: add support for memory oversubscription
        # memory_max = [[ $resources.memory_max ]]
      }
    }
  }
}

[[/* add diagnostic information to bottom of job-spec */]]
# generated by `[[ env "USER" ]]` on [[ now | date "2006-01-01 at 15:04:05" ]]
