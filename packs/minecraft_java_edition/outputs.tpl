[[- if .minecraft_java_edition.verbose_output ]]
# Job: _[[ .minecraft_java_edition.job_name ]]_ (v[[ .nomad_pack.pack.version ]])

  Region:    `[[ .minecraft_java_edition.region ]]`
  DC(s):     `[[ .minecraft_java_edition.datacenters | toJson ]]`
  Namespace: `[[ .minecraft_java_edition.namespace ]]`
  Name:      `[[ .minecraft_java_edition.job_name ]]`
  Count:     [[ .minecraft_java_edition.count ]]

## Image:

  Registry:  `[[ .minecraft_java_edition.image.registry ]]`
  Namespace: `[[ .minecraft_java_edition.image.namespace ]]`
  Image:     `[[ .minecraft_java_edition.image.image ]]:[[ .minecraft_java_edition.image.tag ]]`
  Digest:    `[[ .minecraft_java_edition.image.digest ]]`
  [[ template "output_image_information" .minecraft_java_edition.image ]]

## Ports:

  [[- range $name, $config := .minecraft_java_edition.ports ]]
  - [[ $name ]]: `[[ $config.port ]]` (type: `[[ $config.type ]]`)
  [[- end ]]

## Resources:

  CPU:    `[[ .minecraft_java_edition.resources.cpu ]]`
  Memory: `[[ .minecraft_java_edition.resources.memory ]]`

## Volumes:

  [[- range $name, $mounts := .minecraft_java_edition.volumes ]]
  - `[[ $mounts.name | quote ]]` (type: [[ $mounts.type ]]) = `[[ $mounts.destination | toPrettyJson ]]` [[ if $mounts.read_only ]](`read-only`)[[ end ]]
  [[- end ]]

[[- if $.minecraft_java_edition.register_consul_service ]]
## Consul:

  Register Service: `[[ .minecraft_java_edition.register_consul_service ]]`
  Service Name:     `[[ .minecraft_java_edition.consul_service_name ]]`
  Service Tags:     `[[ .minecraft_java_edition.consul_service_tags | toPrettyJson ]]`
[[ end ]]

## Configuration:

  [[- range $name, $config := .minecraft_java_edition.config ]]
  [[- if not (empty $config) ]]
  [[ $name ]] = `[[ $config ]]`
  [[- end ]]
  [[- end ]]

[[ end -]]
