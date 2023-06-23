[[- if .my.verbose_output ]]
# Job: _[[ .my.job_name ]]_ (`v[[ .nomad_pack.pack.version ]]`)

  Region:    `[[ .my.region ]]`
  DC(s):     `[[ .my.datacenters | toJson ]]`
  Namespace: `[[ .my.namespace ]]`
  Name:      `[[ .my.job_name ]]`
  Count:     `[[ .my.count ]]`

## Ports

  [[- range $name, $config := .my.ports ]]
  - `[[ $name ]]`: `[[ $config.port ]]` (type: `[[ $config.type ]]` [[ if and (eq $config.type "http") (eq $config.protocol "https") ]]protocol: `https`[[ end ]])
  [[- end ]]

## Resources

  CPU:    [[ .my.resources.cpu ]] MHz
  Memory: [[ .my.resources.memory ]] MB

## Volumes

  [[- range $name, $mounts := .my.volumes ]]
  - `[[ $mounts.name ]]` = `[[ $mounts.destination | toPrettyJson ]]` (type: `[[ $mounts.type ]]`[[ if $mounts.read_only ]], read-only[[ end ]])
  [[- end ]]

## Service

  Service Provider: `[[ .my.service_provider ]]`
  Service Name:     `[[ .my.job_name | replace "_" "-" | trunc 63 | quote ]]`

  Service Tags:
    [[- range $name := .my.job_tags ]]
    - `[[ $name ]]`
    [[- end ]]

## Application Configuration

```env
[[- template "configuration" . ]]
```

## URLs:

  Datadog Interface:  [[ .my.app_dd_url ]]
  Infrastructure Map: [[ .my.app_dd_url ]]/infrastructure/map?fillby=avg%%3Adatadog.agent.running&filter=[[ first .my.dd_tags | replace ":" "%%3A" ]]

[[ end -]]
