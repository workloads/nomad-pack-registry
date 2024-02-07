[[- define "util_action_print_nomad_env" ]]
[[- if (eq (var "utility_actions.print_nomad_env" .) true) ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/action
action "print_nomad_env" {
  command = "/bin/sh"

  args = [
    "-c",
    "env | sort | grep NOMAD_",
  ]
}
[[- end -]]
[[- end -]]
