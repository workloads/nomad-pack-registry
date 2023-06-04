[[/*
  Helpers for the main *.nomad.tpl template,
  see https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-writing-packs
*/]]

[[/* Default to `pack_name` from `metadata.hcl` if job name wasn't provided in `variables.hcl` */]]
[[ define "job_name" ]]
[[- if eq . "" ]]
[[- .nomad_pack.pack.name | quote ]]
[[- else ]]
[[- . | quote ]]
[[- end ]]
[[- end ]]

[[/* only deploy to a Nomad Region if one was specified */]]
[[ define "region" ]]
[[- if ne . "" -]]
  region      = [[ . | quote ]]
[[- end -]]
[[- end -]]

[[/* iterate over `var.ports` to map Network Ports */]]
[[ define "network_ports" ]]
[[ $enable_rcon := .config.enable_rcon ]]
[[- range $name, $config := .ports ]]
      [[- /* only enable mapping of `rcon` port if `config.enable_rcon` is true */]]
      [[- if or (ne $name "rcon") (and (eq $name "rcon") (eq $enable_rcon true)) ]]
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#port-parameters
      port [[ $name | quote ]] {
        static = [[ $config.port ]]
        to     = [[ $config.port ]]
      }
      [[ end ]]
[[- end ]]
[[- end ]]

[[/* iterate over configuration to create Service */]]
[[ define "service" ]]
    # see https://developer.hashicorp.com/nomad/docs/job-specification/service
    service {
      [[- if (eq .service_provider "consul") ]]
      name     = [[ .consul_service_name | replace "_" "-" | trunc 63 | quote ]]
      tags     =  [[ .consul_service_tags | toJson ]]
      [[- else ]]
      name     = [[ .job_name | replace "_" "-" | trunc 63 | quote ]]
      tags     =  [[ .job_tags | toJson ]]
      [[- end ]]

      port     = [[ .ports | keys | first | quote ]]
      provider = [[ .service_provider | quote ]]

      [[ template "service_checks" . ]]
  }
[[- end ]]

[[/* iterate over configuration to create Liveness Checks */]]
[[ define "service_checks" ]]
      [[- /* only enable liveness probe for `rcon` port if `$enable_rcon` is true */]]
      [[- $enable_rcon := .config.enable_rcon -]]
      [[- range $name, $check := .ports ]]
      [[- if or (ne $name "rcon") (and (eq $name "rcon") (eq $enable_rcon true)) ]]
      check {
        name     = [[ $name | quote ]]
        type     = [[ $check.type | quote ]]

        [[- if eq $check.type "http" ]]
        path = [[ $check.path | quote ]]
        [[ end ]]

        interval = "10s"
        timeout  = "2s"
      }
      [[ end ]]
      [[- end ]]
[[ end ]]

[[/* iterate over `var.volumes` to create Volume Mounts */]]
[[ define "group_volumes" ]]
[[- range $index, $mount := . ]]
    volume [[ $mount.name | quote ]] {
      source    = [[ $mount.name | quote ]]
      type      = [[ $mount.type | quote ]]
      read_only = [[ $mount.read_only ]]
    }
[[ end ]]
[[- end ]]

[[/* iterate over list items of `var.volumes` */]]
[[ define "task_volume_mounts" ]]
[[- range $index, $mount := . ]]
      volume_mount {
        volume      = [[ $mount.name | quote ]]
        destination = [[ $mount.destination | quote ]]
        read_only   = [[ $mount.read_only ]]
      }
[[ end ]]
[[- end -]]

[[/* iterate over map items of `var.ports` */]]
[[ define "task_ports" -]]
        # see https://developer.hashicorp.com/nomad/docs/drivers/docker#ports
        ports = [
          [[- /* only enable mapping of `rcon` port if `$enable_rcon` is true */]]
          [[- $enable_rcon := .config.enable_rcon -]]
          [[- range $name, $port := .ports ]]
          [[- if or (ne $name "rcon") (and (eq $name "rcon") (eq $enable_rcon true)) ]]
          [[ $name | quote ]],
          [[- end ]]
          [[- end ]]
        ]
[[- end ]]

[[/* pretty-print Image information */]]
[[ define "output_image_information" ]]
[[- if eq .registry "docker.io" -]]
    URL:       https://hub.docker.com/layers/[[ .namespace ]]/[[ .image ]]/[[ .tag ]]/images/[[ .digest | replace ":" "-" ]]
[[- else -]]
    URL:       https://[[ .registry ]]/[[ .namespace ]]/[[ .image ]]:[[ .tag ]]
[[ end -]]
[[ end -]]
