[[/*
  Helpers for the `pack.nomad.tpl` template,
  see https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-writing-packs
*/]]


[[ define "service" ]]
    [[- $job_name := .job_name -]]
    [[- $job_tags := .job_tags -]]
    [[- $service_provider := .service_provider -]]
    [[- $ports := .ports -]]

    [[- /* only enable service `rcon` port if `$enable_rcon` is true */]]
    [[- $enable_rcon := .app_enable_rcon -]]
    [[ range $name, $port := .ports ]]
    [[- if or (ne $name "rcon") (and (eq $name "rcon") (eq $enable_rcon true)) ]]

    [[- end ]]
    [[ end ]]
[[- end ]]
