[[/*
  Helpers for the main *.nomad.tpl template,
  see https://github.com/hashicorp/nomad-pack/blob/main/docs/writing-packs.md#helper-templates
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

[[/* iterate over `var.config_ports` to map Network Ports */]]
[[ define "network_ports" ]]
[[- range $name, $config := . ]]
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#port-parameters
      port [[ $name | quote ]] {
        static = [[ $config.port ]]
        to     = [[ $config.port ]]
      }
[[ end ]]
[[- end ]]

[[/* iterate over `var.config_ports` to create Liveness Checks */]]
[[ define "service_checks" ]]
      [[- range $name, $check := . ]]
      check {
        name     = "liveness-probe-[[ $name ]]"
        type     = [[ $check.type | quote ]]

        [[- if eq $check.type "http" ]]
        path = [[ $check.path | quote ]]
        [[ end ]]

        interval = "10s"
        timeout  = "2s"
      }
      [[ end ]]
[[ end ]]

[[/* iterate over `var.config_mounts` to create Volume Mounts */]]
[[ define "group_volumes" ]]
[[- range $index, $mount := . ]]
    volume [[ $mount.name | quote ]] {
      source    = [[ $mount.name | quote ]]
      type      = [[ $mount.type | quote ]]
      read_only = [[ $mount.read_only ]]
    }
[[ end ]]
[[- end ]]

[[/* TODO */]]
[[/* Define HTTPs port to bind to */]]
[[ define "arg_bind_https" ]]
[[- if . ]]
          "--bind-https", "[[ .config.bind_addr ]]:[[ .config_ports.https.port ]]",
[[- end ]]
[[- end ]]

[[/* uterate over list items of `var.config_mounts` if provided in `variables.hcl` */]]
[[ define "task_volume_mounts" ]]
[[- range $index, $mount := . ]]
      volume_mount {
        volume      = [[ $mount.name | quote ]]
        destination = [[ $mount.destination | quote ]]
        read_only   = [[ $mount.read_only ]]
      }
[[ end ]]
[[- end -]]

[[/* iterate over map items of `var.config_ports` if provided in `variables.hcl` */]]
[[ define "task_ports" ]]
        # see https://developer.hashicorp.com/nomad/docs/drivers/docker#ports
        ports = [
          [[- range $name, $config := . ]]
          [[ $name | quote ]],
          [[- end ]]
        ]
[[- end ]]

[[/* pretty-print Image information */]]
[[ define "output_image_information" ]]
[[- if eq .registry "hub.docker.com" -]]
    URL:       https://hub.docker.com/layers/[[ .namespace ]]/[[ .image ]]/[[ .tag ]]/images/[[ .digest | replace ":" "-" ]]
[[- else -]]
    URL:       https://[[ .registry ]]/[[ .namespace ]]/[[ .image ]]:[[ .tag ]]
[[ end -]]
[[ end -]]
