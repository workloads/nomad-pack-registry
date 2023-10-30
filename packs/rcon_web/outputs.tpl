[[- if .my.nomad_pack_verbose_output ]]
# Job: _[[ var "nomad_job_name" . ]]_ (`v[[ meta "pack.version" . ]]`)

  Region:    `[[ .my.nomad_job_region ]]`
  DC(s):     `[[ .my.nomad_job_datacenters | toJson ]]`
  Namespace: `[[ .my.nomad_job_namespace ]]`
  Name:      `[[ .my.nomad_job_name ]]`
  Count:     `[[ .my.nomad_group_count ]]`

## Image

  Registry:  `[[ .my.nomad_task_image.registry ]]`
  Namespace: `[[ .my.nomad_task_image.namespace ]]`
  Image:     `[[ .my.nomad_task_image.image ]]:[[ .my.nomad_task_image.tag ]]`
  Digest:    `[[ .my.nomad_task_image.digest ]]`

  [[- /* pretty-print Image information */]]
  [[- if eq .my.nomad_task_image.registry "index.docker.io" ]]
  URL:       https://hub.docker.com/layers/[[ .my.nomad_task_image.namespace ]]/[[ .my.nomad_task_image.image ]]/[[ .my.nomad_task_image.tag ]]/images/[[ .my.nomad_task_image.digest | replace ":" "-" ]]
  [[ else ]]
  URL:       https://[[ .my.nomad_task_image.registry ]]/[[ .my.nomad_task_image.namespace ]]/[[ .my.nomad_task_image.image ]]:[[ .my.nomad_task_image.tag ]]
  [[ end ]]

## Ports

  [[- range $name, $config := .my.nomad_group_ports ]]
  - `[[ $name ]]`: `[[ $config.port ]]` (type: `[[ $config.type ]]` [[ if and (eq $config.type "http") (eq $config.protocol "https") ]]protocol: `https`[[ end ]])
  [[- end ]]

## Resources

  CPU:    [[ .my.nomad_task_resources.cpu ]] MHz
  Memory: [[ .my.nomad_task_resources.memory ]] MB

[[- if .my.nomad_group_volumes ]]
## Volumes

  [[- range $name, $mounts := .my.nomad_group_volumes ]]
  - `[[ $mounts.name ]]` = `[[ $mounts.destination | toPrettyJson ]]` (type: `[[ $mounts.type ]]`[[ if $mounts.read_only ]], read-only[[ end ]])
  [[- end ]]
[[ end ]]

## Service

  Service Provider: `[[ .my.service_provider ]]`
  Service Name:     `[[ .my.nomad_job_name | replace "_" "-" | trunc 63 | quote ]]`

  Service Tags:
    [[- range $name := .my.nomad_group_tags ]]
    - `[[ $name ]]`
    [[- end ]]

## Application Configuration

```env
[[- template "configuration" . ]]
```

## URLs:

  [[- if .my.nomad_group_ports.main ]]
  web interface: http://127.0.0.1:[[ .my.nomad_group_ports.main.port ]][[ .my.nomad_group_ports.main.path ]]
  [[- end ]]

[[ end -]]
