[[/* remove `rcon` from `$ports` if `.my.app_enable_rcon` is false */]]
[[- $ports := .my.ports ]]
[[- if (ne .my.app_enable_rcon true) ]]
[[ unset $ports "rcon" ]]
[[- end ]]

# see https://developer.hashicorp.com/nomad/docs/job-specification/job
job "[[ .my.job_name ]]" {
  region      = "[[ .my.region ]]"
  datacenters = [[ .my.datacenters | toJson ]]
  type        = "service"
  namespace   = "[[ .my.namespace ]]"
  priority    = [[ .my.priority ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/group
  group "[[ .my.group_name ]]" {
    count = [[ .my.count ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
    ephemeral_disk {
      migrate = [[ .my.ephemeral_disk.migrate ]]
      size    = [[ .my.ephemeral_disk.size ]]
      sticky  = [[ .my.ephemeral_disk.sticky ]]
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/network
    network {
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
      mode = "[[ .my.network_mode ]]"

      [[/* iterate over `$ports` to create Port Mappings */]]
      [[- range $name, $config := $ports ]]
      port "[[ $name ]]" {
        static = [[ $config.port ]]
        to     = [[ $config.port ]]
      }
      [[ end ]]
    }

    [[- $job_tags := .my.job_tags -]]
    [[- $service_name := .my.service_name_prefix -]]
    [[- $service_provider := .my.service_provider -]]
    [[/* iterate over `$ports` to map Services */]]
    [[ range $name, $port := $ports ]]
    # see https://developer.hashicorp.com/nomad/docs/job-specification/service
    service {
      name     = "[[ $service_name | replace "_" "-" | trunc 63 ]]-[[ $name ]]"
      tags     = [[ $job_tags | toJson ]]
      port     = [[ $port.port ]]
      provider = "[[ $service_provider ]]"

      # see https://developer.hashicorp.com/nomad/docs/job-specification/check
      check {
        name     = [[ $name | quote ]]
        type     = [[ $port.type | quote ]]
        [[- if eq $port.type "http" ]]
        path     = [[ $port.path | quote ]]
        [[- end ]]
        interval = "30s"
        timeout  = "15s"
      }
    }
    [[ end ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/restart
    restart {
      attempts = [[ .my.restart_logic.attempts ]]
      interval = "[[ .my.restart_logic.interval ]]"
      delay    = "[[ .my.restart_logic.delay ]]"
      mode     = "[[ .my.restart_logic.mode ]]"
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/volume
    [[/* iterate over `var.volumes` to create Volumes */]]
    [[- range $index, $mount := .my.volumes ]]
    volume [[ $mount.name | quote ]] {
      source    = [[ $mount.name | quote ]]
      type      = [[ $mount.type | quote ]]
      read_only = [[ $mount.read_only ]]
    }
    [[ end ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/task
    task "[[ .my.task_name ]]" {
      # see https://developer.hashicorp.com/nomad/docs/drivers
      driver = "[[ .my.driver ]]"

      # see https://developer.hashicorp.com/nomad/docs/drivers/docker
      # and https://developer.hashicorp.com/nomad/plugins/drivers/podman
      config {
        image = "[[ .my.image.registry ]]/[[ .my.image.namespace ]]/[[ .my.image.image ]]:[[ .my.image.tag ]]@[[ .my.image.digest ]]"

        # see https://developer.hashicorp.com/nomad/docs/drivers/docker#ports
        # and https://developer.hashicorp.com/nomad/plugins/drivers/podman#ports
        ports = [
          [[- range $name, $port := $ports ]]
          [[ $name | quote ]],
          [[- end ]]
        ]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/env
      env {
        [[- range $name, $value := .my -]]
        [[ if $name | hasPrefix "app_" ]]
        [[ $name | trimPrefix "app_" | upper ]] = "[[ $value | toString ]]"
        [[- end ]]
        [[- end ]]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/volume_mount
      [[/* iterate over `var.volumes` to create Volume Mounts */]]
      [[- range $index, $mount := .my.volumes ]]
      volume_mount {
          volume      = [[ $mount.name | quote ]]
          destination = [[ $mount.destination | quote ]]
          read_only   = [[ $mount.read_only ]]
      }
      [[ end ]]

      # see https://developer.hashicorp.com/nomad/docs/job-specification/resources
      resources {
        cpu        = [[ .my.resources.cpu ]]
        cores      = [[ .my.resources.cores | default "null" ]]
        memory     = [[ .my.resources.memory ]]

        # TODO: add support for memory oversubscription
        # memory_max = [[ .my.resources.memory_max ]]
      }
    }
  }
}

[[/* add diagnostic information to bottom of job-spec */]]
# generated by `[[ env "USER" ]]` on [[ now | date "2006-01-01 at 15:04:05" ]]