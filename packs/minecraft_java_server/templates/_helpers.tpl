[[/*
  Helpers for the `minecraft_java_server.nomad.tpl` template,
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
    [[- $consul_service_name := .consul_service_name -]]
    [[- $consul_service_tags := .consul_service_tags -]]
    [[- $job_name := .job_name -]]
    [[- $job_tags := .job_tags -]]
    [[- $service_provider := .service_provider -]]
    [[- $ports := .ports -]]

    [[- /* only enable service `rcon` port if `$enable_rcon` is true */]]
    [[- $enable_rcon := .config.enable_rcon -]]
    [[ range $name, $port := .ports ]]
    [[- if or (ne $name "rcon") (and (eq $name "rcon") (eq $enable_rcon true)) ]]
    # see https://developer.hashicorp.com/nomad/docs/job-specification/service
    service {
      [[- if (eq .service_provider "consul") ]]
      [[- $service_name := printf "%s-%s" $consul_service_name $port.name ]]
      name     = [[ $service_name | replace "_" "-" | trunc 63 | quote ]]
      tags     = [[ $consul_service_tags | toJson ]]
      [[- else ]]
      name     = [[ $port.name | replace "_" "-" | trunc 63 | quote ]]
      tags     = [[ $job_tags | toJson ]]
      [[- end ]]

      port     = [[ $port.port ]]
      provider = [[ $service_provider | quote ]]

      check {
        name = [[ $name | quote ]]
        type = [[ $port.type | quote ]]

        [[- if eq $port.type "http" ]]
        path = [[ $port.path | quote ]]
        [[- end ]]

        interval = "30s"
        timeout  = "15s"
      }
    }
    [[- end ]]
    [[ end ]]
[[- end ]]

[[/* iterate over `var.volumes` to create Volumes */]]
[[ define "volumes" ]]
[[- range $index, $mount := . ]]
    volume [[ $mount.name | quote ]] {
      type      = [[ $mount.type | quote ]]
      read_only = [[ $mount.read_only ]]
    }
[[ end ]]

[[- end ]]
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
