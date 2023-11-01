[[- if var "nomad_pack_verbose_output" . ]]
# Job: _[[ var "nomad_job_name" . ]]_ (`v[[ meta "pack.version" . ]]`)

  Region:    `[[ var "nomad_job_region" . ]]`
  DC(s):     `[[ var "nomad_job_datacenters" . | toJson ]]`
  Namespace: `[[ var "nomad_job_namespace" . ]]`
  Name:      `[[ var "nomad_job_name" . ]]`
  Count:     `[[ var "nomad_group_count" . ]]`

## Ports

  [[- range $name, $config := var "nomad_group_ports" . ]]
  - `[[ $name ]]`: `[[ $config.port ]]` (type: `[[ $config.type ]]` [[ if and (eq $config.type "http") (eq $config.protocol "https") ]]protocol: `https`[[ end ]])
  [[- end ]]

## Resources

  CPU:    [[ var "nomad_task_resources.cpu" . ]] MHz
  Memory: [[ var "nomad_task_resources.memory" . ]] MB

[[- if var "nomad_group_volumes" . ]]
## Volumes

  [[- range $name, $mounts := var "nomad_group_volumes" . ]]
  - `[[ $mounts.name ]]` = `[[ $mounts.destination | toPrettyJson ]]` (type: `[[ $mounts.type ]]`[[ if $mounts.read_only ]], read-only[[ end ]])
  [[- end ]]
[[ end ]]

## Service

  Service Provider: `[[ var "service_provider" . ]]`
  Service Name:     `[[ var "nomad_job_name" . | replace "_" "-" | trunc 63 | quote ]]`

  Service Tags:
    [[- range $name := var "nomad_group_tags" . ]]
    - `[[ $name ]]`
    [[- end ]]

## Application Configuration

```env
[[- template "configuration" . ]]
```

## URLs:

  Datadog Interface:     [[ var "app_dd_url" . ]]
  Infrastructure Map:    [[ var "app_dd_url" . ]]/infrastructure/map?fillby=avg%%3Adatadog.agent.running&filter=[[ first var "dd_tags" . | replace ":" "%%3A" ]]

  [[- if var "nomad_group_ports.gui" . ]]
  Datadog Agent Manager: [[ var "nomad_group_ports.gui.protocol" . ]]://[[ var "app_dd_bind_host" . ]]:[[ var "nomad_group_ports.gui.port" . ]][[ var "nomad_group_ports.gui.path" . ]]
  [[- end ]]

[[ end -]]
