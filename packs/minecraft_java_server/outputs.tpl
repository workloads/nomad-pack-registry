[[- if .minecraft_java_server.verbose_output ]]
# Job: _[[ .minecraft_java_server.job_name ]]_ (v[[ .nomad_pack.pack.version ]])

  Region:    `[[ .minecraft_java_server.region ]]`
  DC(s):     `[[ .minecraft_java_server.datacenters | toJson ]]`
  Namespace: `[[ .minecraft_java_server.namespace ]]`
  Name:      `[[ .minecraft_java_server.job_name ]]`
  Count:     [[ .minecraft_java_server.count ]]

## Image:

  Registry:  `[[ .minecraft_java_server.image.registry ]]`
  Namespace: `[[ .minecraft_java_server.image.namespace ]]`
  Image:     `[[ .minecraft_java_server.image.image ]]:[[ .minecraft_java_server.image.tag ]]`
  Digest:    `[[ .minecraft_java_server.image.digest ]]`
  [[ template "output_image_information" .minecraft_java_server.image ]]

## Ports:

  [[- range $name, $config := .minecraft_java_server.ports ]]
  - [[ $name ]]: `[[ $config.port ]]` (type: `[[ $config.type ]]`)
  [[- end ]]

## Resources:

  CPU:    `[[ .minecraft_java_server.resources.cpu ]]`
  Memory: `[[ .minecraft_java_server.resources.memory ]]`

## Volumes:

  [[- range $name, $mounts := .minecraft_java_server.volumes ]]
  - `[[ $mounts.name | quote ]]` (type: [[ $mounts.type ]]) = `[[ $mounts.destination | toPrettyJson ]]` [[ if $mounts.read_only ]](`read-only`)[[ end ]]
  [[- end ]]

[[- if $.minecraft_java_server.register_consul_service ]]
## Consul:

  Register Service: `[[ .minecraft_java_server.register_consul_service ]]`
  Service Name:     `[[ .minecraft_java_server.consul_service_name ]]`
  Service Tags:     `[[ .minecraft_java_server.consul_service_tags | toPrettyJson ]]`
[[ end ]]

## Configuration:

  [[- range $name, $config := .minecraft_java_server.config ]]
  [[- if not (empty $config) ]]
  [[ $name ]] = `[[ $config ]]`
  [[- end ]]
  [[- end ]]

[[ end -]]
