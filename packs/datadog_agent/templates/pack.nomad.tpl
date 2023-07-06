[[- $ports := .my.ports ]]

# see https://developer.hashicorp.com/nomad/docs/job-specification/job
job "[[ .my.job_name ]]" {
  region      = "[[ .my.region ]]"
  datacenters = [[ .my.datacenters | toJson ]]
  type        = "system"
  namespace   = "[[ .my.namespace ]]"
  priority    = [[ .my.priority ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/group
  group "[[ .my.group_name ]]" {
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
        static       = [[ $config.port ]]
        to           = [[ $config.port ]]
        [[- if $config.host_network ]]
        host_network = "[[ $config.host_network ]]"
        [[- end ]]
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
      name     = "[[ $service_name | replace "_" "-" | trunc 20 ]]-[[ $name | replace "_" "-" | trunc 43 ]]"
      tags     = [[ $job_tags | toJson ]]
      port     = [[ $port.port ]]
      provider = "[[ $service_provider ]]"

      [[- /* specifically ignore IPC, GUI, and DogStatsD ports, as the check require unsupported strategies */]]
      [[ if not (or (eq $port.port 5001) (eq $port.port 5002) (eq $port.port 8125)) ]]
      # see https://developer.hashicorp.com/nomad/docs/job-specification/check
      check {
        name            = "[[ $name ]]"
        type            = "[[ $port.type ]]"
        [[- if eq $port.type "http" ]]
        path            = "[[ $port.path ]]"
        protocol        = "[[ $port.protocol ]]"
        [[- end ]]
        interval        = "[[ $port.check_interval ]]"
        timeout         = "[[ $port.check_timeout ]]"
      }
      [[ end ]]
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
    [[- range $index, $mount := .my.nomad_group_volumes ]]
    volume "[[ $mount.name ]]" {
      source    = "[[ $mount.name ]]"
      type      = "[[ $mount.type ]]"
      read_only = [[ $mount.read_only ]]
    }
    [[ end ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/task
    task "[[ .my.task_name ]]" {
      # see https://developer.hashicorp.com/nomad/docs/drivers
      driver = "[[ .my.driver ]]"

      # see https://developer.hashicorp.com/nomad/docs/drivers/raw_exec
      # and https://developer.hashicorp.com/nomad/docs/drivers/exec
      config {
        # see https://docs.datadoghq.com/agent/guide/agent-commands/?tab=agentv6v7
        command = "datadog-agent"
        args    = ["run"]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/env
      env {
        [[- template "configuration" . ]]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/template
      template {
        change_mode = "restart"

        # render template with sensitive data
        # see https://app.datadoghq.com/account/settings
        data = <<DATA
          {{- with nomadVar "nomad/jobs/[[ .my.job_name ]]" -}}
          DD_API_KEY = "{{ .api_key }}"
          {{- end -}}
        DATA

        # make it harder to leak sensitive data by writing to the Secrets directory
        destination          = "${NOMAD_SECRETS_DIR}/env.vars"
        env                  = true
        error_on_missing_key = true
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
