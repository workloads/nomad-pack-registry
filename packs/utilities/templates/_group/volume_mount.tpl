[[/* iterate over `var.volumes` to create Volume Mounts */]]
[[- define "util_job_group_volume_mount" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/volume_mount
[[- range $index, $mount := var "nomad_group_volumes" . ]]
volume_mount {
  volume      = "[[ $mount.name ]]"
  destination = "[[ $mount.destination ]]"
  read_only   = [[ $mount.read_only ]]
}
[[ end ]]
[[- end ]]
