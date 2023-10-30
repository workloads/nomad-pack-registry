[[/* format all `app_` variables in the best-possible way */]]
[[- define "configuration" ]]
  [[- range $name, $value := vars . -]]
    [[ if and ($name | hasPrefix "app_") (printf "%v" $value) ]]
      [[- $clean_name := $name | trimPrefix "app_" | upper ]]
      [[- if (eq "slice" (kindOf $value)) ]]
        [[ $clean_name ]] = "[[ $value | toStrings | join " " ]]"
      [[- else if (or (eq "int" (kindOf $value)) (eq "bool" (kindOf $value))) ]]
        [[ $clean_name ]] = "[[ $value ]]"
      [[- else ]]
        [[ $clean_name ]] = [[ $value | toString | quote ]]
      [[- end ]]
    [[- end ]]
  [[- end ]]

        DD_TAGS = "[[ var "dd_tags" . | toStrings | join " " ]]"

  [[- if (eq (var "include_dd_extra_tags" . ) true) ]]
        DD_EXTRA_TAGS = "[[ var "dd_extra_tags" . | toStrings | join " " ]]"
  [[- end ]]
        DD_APM_RECEIVER_PORT = [[ var "nomad_group_ports.apm_receiver.port" .   ]]
  [[- if var "nomad_group_ports.ipc" . ]]
        DD_CMD_PORT = [[ var "nomad_group_ports.ipc.port" .   ]]
  [[- end ]]
  [[- if var "nomad_group_ports.dogstatsd" . ]]
        DD_EXPVAR_PORT = [[ var "nomad_group_ports.expvar.port" .   ]]
  [[- end ]]
  [[- if var "nomad_group_ports.dogstatsd" . ]]
        DD_USE_DOGSTATSD = true
        DD_DOGSTATSD_PORT = [[ var "nomad_group_ports.dogstatsd.port" .   ]]
  [[- end ]]
        DD_DOGSTATSD_STATS_PORT = [[ var "nomad_group_ports.expvar.port" .   ]]
  [[- if var "nomad_group_ports.gui" . ]]
        DD_GUI_PORT = [[ var "nomad_group_ports.gui.port" .   ]]
  [[- end ]]
  [[- if var "nomad_group_ports.healthcheck" . ]]
        DD_HEALTH_PORT = [[ var "nomad_group_ports.healthcheck.port" .   ]]
  [[- end ]]
  [[- if var "nomad_group_ports.debug" . ]]
        DD_PROCESS_CONFIG_EXPVAR_PORT = [[ var "nomad_group_ports.debug.port" .   ]]
  [[- end ]]
[[- end ]]
