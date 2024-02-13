[[- define "action_print_baedge_env" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/action
action "print-baedge-env" {
  command = "/bin/sh"

  args = [
    "-c",
    "env | sort | grep BAEDGE_",
  ]
}
[[- end -]]
