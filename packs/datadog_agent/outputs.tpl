[[- if .my.verbose_output ]]
# Job: _[[ .my.job_name ]]_ (`v[[ .nomad_pack.pack.version ]]`)

  Region:    `[[ .my.region ]]`
  DC(s):     `[[ .my.datacenters | toJson ]]`
  Namespace: `[[ .my.namespace ]]`
  Name:      `[[ .my.job_name ]]`
  Count:     `[[ .my.count ]]`

## Ports

  [[- /* remove `rcon` from `$ports` if `.my.app_enable_rcon` is false */]]
  [[- $ports := .my.ports ]]
  [[/* - if (ne .my.app_enable_rcon true) */]]
  [[/* unset $ports "rcon" */]]
  [[/* - end */]]
  [[- range $name, $config := $ports ]]
  - `[[ $name ]]`: `[[ $config.port ]]` (type: `[[ $config.type ]]`)
  [[- end ]]

## Resources

  CPU:    [[ .my.resources.cpu ]] MHz
  Memory: [[ .my.resources.memory ]] MB

## Volumes
  [[ range $name, $mounts := .my.volumes ]]
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

[[ end -]]
