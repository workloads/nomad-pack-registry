[[/* format all `app_` variables in the best-possible way */]]
[[- define "configuration" ]]
  [[- range $name, $value := .my -]]
    [[ if and ($name | hasPrefix "app_") ($value) ]]
      [[- $clean_name := $name | trimPrefix "app_" | upper ]]
      [[- if (eq "slice" (kindOf $value)) ]]
        [[ $clean_name ]] = "[[ $value | toStrings | join " " ]]"
      [[- else if (or (eq "int" (kindOf $value)) (eq "bool" (kindOf $value))) ]]
        [[ $clean_name ]] = [[ $value ]]
      [[- else ]]
        [[ $clean_name ]] = [[ $value | toString | quote ]]
      [[- end ]]
    [[- end ]]
  [[- end ]]

        DD_TAGS = "[[ .my.dd_tags | toStrings | join " " ]]"

  [[- if (eq .my.include_dd_extra_tags true) ]]
        DD_EXTRA_TAGS = "[[ .my.dd_extra_tags | toStrings | join " " ]]"
  [[- end ]]
        DD_APM_RECEIVER_PORT = [[ .my.nomad_group_ports.apm_receiver.port ]]
  [[- if .my.nomad_group_ports.ipc ]]
        DD_CMD_PORT = [[ .my.nomad_group_ports.ipc.port ]]
  [[- end ]]
  [[- if .my.nomad_group_ports.dogstatsd ]]
        DD_EXPVAR_PORT = [[ .my.nomad_group_ports.expvar.port ]]
  [[- end ]]
  [[- if .my.nomad_group_ports.dogstatsd ]]
        DD_USE_DOGSTATSD = true
        DD_DOGSTATSD_PORT = [[ .my.nomad_group_ports.dogstatsd.port ]]
  [[- end ]]
        DD_DOGSTATSD_STATS_PORT = [[ .my.nomad_group_ports.expvar.port ]]
  [[- if .my.nomad_group_ports.gui ]]
        DD_GUI_PORT = [[ .my.nomad_group_ports.gui.port ]]
  [[- end ]]
  [[- if .my.nomad_group_ports.healthcheck ]]
        DD_HEALTH_PORT = [[ .my.nomad_group_ports.healthcheck.port ]]
  [[- end ]]
  [[- if .my.nomad_group_ports.debug ]]
        DD_PROCESS_CONFIG_EXPVAR_PORT = [[ .my.nomad_group_ports.debug.port ]]
  [[- end ]]
[[- end ]]
