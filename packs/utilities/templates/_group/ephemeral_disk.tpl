[[/* iterate over `var.volumes` to create Volumes */]]
[[- define "util_job_group_ephemeral_disk" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
ephemeral_disk {
  [[- $ephemeral_disk := var "nomad_group_ephemeral_disk" . ]]
  migrate = [[ $ephemeral_disk.migrate ]]
  size    = [[ $ephemeral_disk.size ]]
  sticky  = [[ $ephemeral_disk.sticky ]]
}
[[- end ]]
