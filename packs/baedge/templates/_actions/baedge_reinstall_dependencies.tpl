[[- define "action_baedge_reinstall_dependencies" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/action
action "baedge-reinstall-dependencies" {
  command = "[[ var "app_binary_pip" . ]]"

  args = [
    "install",
    "--requirement",

    # `requirements.txt` should be stored inside the app directory
    "[[ var "app_application_directory" . ]]/requirements.txt",
  ]
}
[[- end -]]
