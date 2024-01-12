[[- define "environment_variables" ]]
# see https://developer.hashicorp.com/nomad/docs/job-specification/env
env {
  # see https://developer.hashicorp.com/nomad/docs/runtime/interpolation#node-attributes
  NOMAD_NODE_POOL = "node.pool" # TODO: change to `${node.pool}`
  NOMAD_ADDR = "unix:///${NOMAD_SECRETS_DIR}/api.sock"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/template
template {
  change_mode = "restart"

  data = <<DATA
    {{- with nomadVar "nomad/jobs/[[ var "nomad_job_name" . ]]" -}}
    # general configuration
    LOG_LEVEL="debug"

    [[ if var "app_enable_hcp_boundary_support" . ]]
    # see https://developer.hashicorp.com/boundary/docs/configuration#hcp_boundary_cluster_id
    BOUNDARY_ADDR="https://{{ .hcp_boundary_cluster_id }}.boundary.hashicorp.cloud"
    [[ end ]]

    BOUNDARY_AUTH_METHOD_ID="{{ .boundary_auth_method_id }}"
    BOUNDARY_PASSWORD="{{ .boundary_password }}"
    BOUNDARY_SCOPE_ID="{{ .boundary_scope_id }}"
    BOUNDARY_TOKEN_OUTPUT_FILE_MODE="[[ var "app_boundary_helper_output_file_mode" . ]]"
    BOUNDARY_USERNAME="{{ .boundary_username }}"

    # Boundary Worker Registration requires unique names for each worker
    # see https://developer.hashicorp.com/boundary/docs/configuration/worker
    BOUNDARY_WORKER_NAME="[[ var "app_worker_name_prefix" . | replace "_" "-" | lower ]]{{ env "NOMAD_SHORT_ALLOC_ID" }}-{{ env "NOMAD_ALLOC_INDEX" }}"
    {{ end }}
  DATA

  destination          = "${NOMAD_TASK_DIR}/.env"
  env                  = true
  error_on_missing_key = true
}
[[- end ]]
