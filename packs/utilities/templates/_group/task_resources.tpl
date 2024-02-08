[[/* iterate over `var.volumes` to create Volumes */]]
[[- define "util_job_group_task_resources" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/resources
resources {
  [[- $resources := var "nomad_task_resources" . ]]
  cpu        = [[ $resources.cpu ]]
  cores      = [[ $resources.cores | default "null" ]]
  memory     = [[ $resources.memory ]]

  # TODO: add support for memory oversubscription
  # memory_max = [[ $resources.memory_max ]]
}
[[- end ]]
