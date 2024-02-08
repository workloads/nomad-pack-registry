[[- define "util_action_print_env" ]]
[[- if (eq (var "utility_actions.print_env" .) true) ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/action
action "print_env" {
  command = "/bin/sh"

  args = [
    "-c",
    "env | sort",
  ]
}
[[- end -]]
[[- end -]]
