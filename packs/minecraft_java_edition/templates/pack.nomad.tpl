[[/* remove `rcon` from `$ports` if `var "app_enable_rcon" .` is false */]]
[[- $ports := var "nomad_group_ports" . ]]
[[- if not (var "app_enable_rcon" . ) ]]
[[ unset $ports "rcon" ]]
[[- end ]]

# see https://developer.hashicorp.com/nomad/docs/job-specification/job
job "[[ var "nomad_job_name" . ]]" {
  region      = "[[ var "nomad_job_region" . ]]"
  datacenters = [[ var "nomad_job_datacenters" . | toJson ]]
  type        = "service"
  namespace   = "[[ var "nomad_job_namespace" . ]]"
  priority    = [[ var "nomad_job_priority" . ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/group
  group "[[ var "nomad_group_name" . ]]" {
    count = [[ var "nomad_group_count" . ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
    ephemeral_disk {
      [[- $ephemeral_disk := var "nomad_group_ephemeral_disk" . ]]
      migrate = [[ $ephemeral_disk.migrate ]]
      size    = [[ $ephemeral_disk.size ]]
      sticky  = [[ $ephemeral_disk.sticky ]]
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/network
    network {
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
      mode = "[[ var "nomad_group_network_mode" . ]]"

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

    [[- $job_tags := var "nomad_group_tags" . -]]
    [[- $service_name := var "nomad_group_service_name_prefix" . -]]
    [[- $service_provider := var "nomad_group_service_provider" . -]]
    [[/* iterate over `$ports` to map Services */]]
    [[ range $name, $port := $ports ]]
    # see https://developer.hashicorp.com/nomad/docs/job-specification/service
    service {
      name     = "[[ $service_name | replace "_" "-" | trunc 20 ]]-[[ $name | replace "_" "-" | trunc 43 ]]"
      tags     = [[ $job_tags | toJson ]]
      port     = "[[ $name ]]"
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
      [[- $restart_logic := var "nomad_group_restart_logic" . ]]
      attempts = [[ $restart_logic.attempts ]]
      interval = "[[ $restart_logic.interval ]]"
      delay    = "[[ $restart_logic.delay ]]"
      mode     = "[[ $restart_logic.mode ]]"
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/volume
    [[/* iterate over `var.volumes` to create Volumes */]]
    [[- range $index, $mount := var "nomad_group_volumes" . ]]
    volume "[[ $mount.name ]]" {
      source    = "[[ $mount.name ]]"
      type      = "[[ $mount.type ]]"
      read_only = [[ $mount.read_only ]]
    }
    [[ end ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/task
    task "[[ var "nomad_task_name" . ]]" {
      # see https://developer.hashicorp.com/nomad/docs/drivers
      driver = "[[ var "nomad_task_driver" . ]]"

      # see https://developer.hashicorp.com/nomad/docs/drivers/docker
      # and https://developer.hashicorp.com/nomad/plugins/drivers/podman
      config {
        [[- $image := var "nomad_task_image" . ]]
        image = "[[ $image.registry ]]/[[ $image.namespace ]]/[[ $image.image ]]:[[ $image.tag ]]@[[ $image.digest ]]"

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
      [[- range $index, $mount := var "nomad_group_volumes" . ]]
      volume_mount {
          volume      = "[[ $mount.name ]]"
          destination = "[[ $mount.destination ]]"
          read_only   = [[ $mount.read_only ]]
      }
      [[ end ]]

      # see https://developer.hashicorp.com/nomad/docs/job-specification/resources
      resources {
        [[- $resources := var "nomad_task_resources" . ]]
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
