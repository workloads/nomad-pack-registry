[[- $ports := var "nomad_group_ports" . ]]

# see https://developer.hashicorp.com/nomad/docs/job-specification/job
job "[[ var "nomad_job_name" . ]]" {
  [[ template "util_job_meta" . ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/group
  group "[[ var "nomad_group_name" . ]]" {
    [[ template "util_job_group_ephemeral_disk" . ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/network
    network {
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
      mode = "[[ var "nomad_group_network_mode" . ]]"

      [[/* iterate over `$ports` to create Port Mappings */]]
      [[- range $name, $config := $ports ]]
      port "[[ $name ]]" {
        static       = [[ $config.port ]]
        to           = [[ $config.port ]]
        [[- if $config.host_network ]]
        host_network = "[[ $config.host_network ]]"
        [[- end ]]
      }
      [[ end ]]
    }

    [[- $job_tags := var "nomad_group_tags" . -]]
    [[- $service_name := var "nomad_group_service_name_prefix" . -]]
    [[- $service_provider := var "nomad_group_service_provider" . -]]
    [[/* iterate over `$ports` to map Services */]]
    [[ range $name, $port := $ports ]]
    # see https://developer.hashicorp.com/nomad/docs/job-specification/service
    service {
      name     = "[[ $service_name | replace "_" "-" | trunc 20 ]]-[[ $name | replace "_" "-" | trunc 43 ]]"
      tags     = [[ $job_tags | toJson ]]
      port     = "[[ $name ]]"
      provider = "[[ $service_provider ]]"

      [[ if eq $port.omit_check false ]]
      # see https://developer.hashicorp.com/nomad/docs/job-specification/check
      check {
        name     = "[[ $name ]]"
        type     = "[[ $port.type ]]"
        [[- if eq $port.type "http" ]]
        method   = "[[ $port.method ]]"
        path     = "[[ $port.path ]]"
        [[- end ]]
        interval = "[[ $port.check_interval ]]"
        timeout  = "[[ $port.check_timeout ]]"
      }
      [[- end ]]
    }
    [[ end ]]

    [[ template "util_job_group_task_restart" . ]]

    [[ template "util_job_group_volume" . ]]

    # main task: Baedge Server
    # see https://developer.hashicorp.com/nomad/docs/job-specification/task
    task "[[ var "nomad_task_name" . ]]-[[ var "nomad_task_name_suffix.server" .]]" {
      # see https://developer.hashicorp.com/nomad/docs/drivers
      driver = "[[ var "nomad_task_driver" . ]]"

      config {
        command = "[[ var "app_binary_python" . ]]"

        args = [
          "-m",
          "http.server",
          "2343",
          #"[[ var "app_application_directory" . ]]",
          #"/[[ var "app_application_file" . ]]",
        ]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/env
      env {
        # application configuration as defined in `variables.hcl`
        [[- template "configuration" . ]]
      }

      # see https://developer.hashicorp.com/nomad/docs/job-specification/template
      template {
        change_mode = "restart"

        data = <<-DATA
          {{- with nomadVar "nomad/jobs/[[ var "nomad_job_name" . ]]" -}}
          # general configuration
          LOG_LEVEL = "{{ .log_level }}"

          # Baedge-specific configuration
          BAEDGE_SERVER_DEBUG = "{{ .baedge_server_debug }}"
          BAEDGE_SERVER_PORT = "[[ var "nomad_group_ports.main.port" . ]]"
          BAEDGE_MEDIA_PATH = "{{ .baedge_media_path }}"
          BAEDGE_HARDWARE_MODEL = "{{ .baedge_hardware_model }}"
          BAEDGE_HARDWARE_REVISION = "{{ .baedge_hardware_revision }}"

          # (human) wearer-specific configuration
          BAEDGE_WEARER_NAME = "{{ .baedge_wearer_name }}"
          BAEDGE_WEARER_TITLE = "{{ .baedge_wearer_title }}"
          BAEDGE_WEARER_SOCIAL = "{{ .baedge_wearer_social }}"
          BAEDGE_WEARER_LINK = "{{ .baedge_wearer_link }}"
          {{ end }}

          # Nomad-specific configuration
          NOMAD_VERSION = "{{ env "attr.nomad.version" }}"
        DATA

        destination          = "${NOMAD_ALLOC_DIR}/.env"
        env                  = true
        error_on_missing_key = true
      }


      # pull latest git changes for repository
      [[ template "action_fetch_changes" . ]]

      # reinstall pip dependencies
      [[ template "action_reinstall_dependencies" . ]]

      [[ template "util_action_print_env" . ]]

      [[ template "action_print_baedge_env" . ]]

      [[ template "util_action_print_nomad_env" . ]]

      [[ template "util_job_group_task_resources" . ]]
    }
  }
}

[[/* add diagnostic information to bottom of job-spec */]]
# generated by `[[ env "USER" ]]` on [[ now | date "2006-01-01 at 15:04:05" ]]
