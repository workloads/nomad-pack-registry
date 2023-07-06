[[- if .my.verbose_output ]]
# Job: _[[ .my.nomad_job_name ]]_ (`v[[ .nomad_pack.pack.version ]]`)

  Region:    `[[ .my.region ]]`
  DC(s):     `[[ .my.nomad_job_datacenters | toJson ]]`
  Namespace: `[[ .my.nomad_job_namespace ]]`
  Name:      `[[ .my.nomad_job_name ]]`
  Count:     `[[ .my.nomad_group_count ]]`

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

  Datadog Interface:     [[ .my.app_dd_url ]]
  Infrastructure Map:    [[ .my.app_dd_url ]]/infrastructure/map?fillby=avg%%3Adatadog.agent.running&filter=[[ first .my.dd_tags | replace ":" "%%3A" ]]

  [[- if .my.nomad_group_ports.gui ]]
  Datadog Agent Manager: [[ .my.nomad_group_ports.gui.protocol ]]://[[ .my.app_dd_bind_host ]]:[[ .my.nomad_group_ports.gui.port ]][[ .my.nomad_group_ports.gui.path ]]
  [[- end ]]
[[ end -]]
