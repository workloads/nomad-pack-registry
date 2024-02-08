[[/* iterate over `var.volumes` to create Volumes */]]
[[- define "util_job_group_task_restart" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/restart
restart {
  [[- $restart_logic := var "nomad_group_restart_logic" . ]]
  attempts = [[ $restart_logic.attempts ]]
  interval = "[[ $restart_logic.interval ]]"
  delay    = "[[ $restart_logic.delay ]]"
  mode     = "[[ $restart_logic.mode ]]"
}
[[- end ]]
