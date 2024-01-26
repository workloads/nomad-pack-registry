[[- $ports := var "nomad_group_ports" . ]]

# see https://developer.hashicorp.com/nomad/docs/job-specification/job
job "[[ var "nomad_job_name" . ]]" {
  region      = "[[ var "nomad_job_region" . ]]"
  datacenters = [[ var "nomad_job_datacenters" . | toJson ]]
  type        = "system"
  namespace   = "[[ var "nomad_job_namespace" . ]]"
  priority    = [[ var "nomad_job_priority" . ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/group
  group "[[ var "nomad_group_name" . ]]" {
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

      [[ if eq $port.omit_check false ]]
      # see https://developer.hashicorp.com/nomad/docs/job-specification/check
      check {
        name     = "[[ $name ]]"
        type     = "[[ $port.type ]]"
        [[- if eq $port.type "http" ]]
        method   = "[[ $port.method ]]"
        path     = "[[ $port.path ]]"
        [[- end ]]
        interval = "[[ $port.check_interval ]]"
        timeout  = "[[ $port.check_timeout ]]"
      }
      [[- end ]]
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

      # see https://developer.hashicorp.com/nomad/docs/job-specification/action
      action "print-nomad-env" {
        command = "/bin/sh"

        args = [
          "-c",
          "env | sort | grep NOMAD_",
        ]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/action
      action "print-image-digest" {
        command = "/bin/sh"

        args = [
          "-c",
          "echo ${NOMAD_IMAGE_DIGEST}",
        ]
      }

      # and https://developer.hashicorp.com/nomad/docs/drivers/exec
      config {
        command = "ping"

        args = [
          "127.0.0.1"
        ]
      }

      [[- $image_digest := var "nomad_task_image.digest" . ]]

      # see https://developer.hashicorp.com/nomad/docs/job-specification/template
      template {
        change_mode          = "noop"

        # TODO: consider file name
        destination          = "${NOMAD_ALLOC_DIR}/.env"
        error_on_missing_key = true
        env                  = true

        [[/*
          TODO: document this extensively and explain why we are pickling this
          structured data from Nomad Pack

          square brackets with `env` would render `env` of the Nomad Pack runner

          --> $image_digest | toJson | b64enc <--
          1.) Render $image_digest (Pack variable) as JSON, then base64 encode it (for quote protection, representation becomes quote-safe)
          context is: Pack rendering pipeline with Sprig functions (no `sprig_` prefix)

          --> $cpu_digest := sprig_b64dec "<data from step 1>" | sprig_fromJson <!--
          2.) Render base64 decoded JSON of step 1, then parse it as JSON, then assign it to the `$cpu_digest` variable
           context is: Nomad Job rendering pipeline, using Sprig functions (with `sprig_` prefix)

           --> printf "%s/%s" (env "attr.kernel.name" | sprig_replace "darwin" "linux") (env "attr.cpu.arch") | index $cpu_digest <!--
           3.) Render kernel name as a string (then replace the kernel name with "linux" if it is "darwin") and add the CPU architecture to it,
               then index the `$cpu_digest` variable with the result
           context is: Nomad Job rendering pipeline, using `env`, `index`, and Sprig functions (with `sprig_` prefix)
          */]]

        data = <<-DATA
        {{- $cpu_digest := sprig_b64dec "[[ $image_digest | toJson | b64enc ]]" | sprig_fromJson -}}
        NOMAD_IMAGE_DIGEST="{{ printf "%s/%s" (env "attr.kernel.name" | sprig_replace "darwin" "linux") (env "attr.cpu.arch") | index $cpu_digest }}"
        DATA
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/env
      env {
        [[- template "configuration" . ]]
      }

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
