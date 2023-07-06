[[- if .my.verbose_output ]]
# Job: _[[ .my.job_name ]]_ (`v[[ .nomad_pack.pack.version ]]`)

  Region:    `[[ .my.region ]]`
  DC(s):     `[[ .my.datacenters | toJson ]]`
  Namespace: `[[ .my.namespace ]]`
  Name:      `[[ .my.job_name ]]`
  Count:     `[[ .my.count ]]`

## Image

  Registry:  `[[ .my.image.registry ]]`
  Namespace: `[[ .my.image.namespace ]]`
  Image:     `[[ .my.image.image ]]:[[ .my.image.tag ]]`
  Digest:    `[[ .my.image.digest ]]`

  [[- /* pretty-print Image information */]]
  [[- if eq .my.image.registry "index.docker.io" ]]
  URL:       https://hub.docker.com/layers/[[ .my.image.namespace ]]/[[ .my.image.image ]]/[[ .my.image.tag ]]/images/[[ .my.image.digest | replace ":" "-" ]]
  [[ else ]]
  URL:       https://[[ .my.image.registry ]]/[[ .my.image.namespace ]]/[[ .my.image.image ]]:[[ .my.image.tag ]]
  [[ end ]]

## Ports

  [[- /* remove `rcon` from `$ports` if `.my.app_enable_rcon` is false */]]
  [[- $ports := .my.ports ]]
  [[- if (ne .my.app_enable_rcon true) ]]
  [[ unset $ports "rcon" ]]
  [[- end ]]
  [[- range $name, $config := $ports ]]
  - `[[ $name ]]`: `[[ $config.port ]]` (type: `[[ $config.type ]]` [[ if and (eq $config.type "http") (eq $config.protocol "https") ]]protocol: `https`[[ end ]])
  [[- end ]]

## Resources

  CPU:    [[ .my.resources.cpu ]] MHz
  Memory: [[ .my.resources.memory ]] MB

[[- if .my.volumes ]]
## Volumes

  [[- range $name, $mounts := .my.volumes ]]
  - `[[ $mounts.name ]]` = `[[ $mounts.destination | toPrettyJson ]]` (type: `[[ $mounts.type ]]`[[ if $mounts.read_only ]], read-only[[ end ]])
  [[- end ]]
[[ end ]]

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

[[ end -]]
