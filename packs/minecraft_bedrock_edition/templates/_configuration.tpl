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
[[- end ]]
