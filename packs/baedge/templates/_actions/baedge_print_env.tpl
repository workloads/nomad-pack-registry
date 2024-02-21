[[- define "action_baedge_print_env" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/action
action "baedge-print-env" {
  command = "/bin/sh"

  args = [
    "-c",
    "env | sort | grep BAEDGE_",
  ]
}
[[- end -]]
