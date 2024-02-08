[[/* iterate over `var.volumes` to create Volumes */]]
[[- define "util_job_group_volume" ]]
  # see https://developer.hashicorp.com/nomad/docs/job-specification/volume
[[- range $index, $mount := var "nomad_group_volumes" . ]]
volume "[[ $mount.name ]]" {
  source    = "[[ $mount.name ]]"
  type      = "[[ $mount.type ]]"
  read_only = [[ $mount.read_only ]]
}
[[ end ]]
[[- end ]]
