[[- define "action_baedge_write_screens" ]]
action "baedge-write-screen-[[ . ]]" {
  command = "/bin/sh"

  args = [
    "-c",
    <<EOT
      curl \
        --location \
        --request POST \
        "http://${NOMAD_ADDR_main}/v1/device/write" \
        --form \
        "screen=[[ . ]]"
    EOT
  ]
}
[[- end -]]

[[- define "action_baedge_clear_screen" ]]
action "baedge-clear-screen" {
  command = "/bin/sh"

  args = [
    "-c",
    <<EOT
      curl \
      --location \
      --request POST \
      "http://${NOMAD_ADDR_main}/v1/device/clear" \
    EOT
  ]
}
[[- end -]]
