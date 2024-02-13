[[- define "action_fetch_changes" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/action
action "fetch-changes" {
  command = "[[ var "app_binary_git" . ]]"

  args = [
    # change working directory into application directory
    "-C",
    "[[ var "app_application_directory" . ]]",
    "pull",
  ]
}
[[- end -]]
