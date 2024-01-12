[[- define "prestart_tasks" ]]
# Pre-Start task to request Boundary Worker registration token
# see https://developer.hashicorp.com/nomad/docs/job-specification/task
task "request_token" {
  # see https://developer.hashicorp.com/nomad/docs/drivers
  driver = "[[ var "nomad_task_driver" . ]]"

  # see https://developer.hashicorp.com/nomad/docs/drivers/raw_exec
  # and https://developer.hashicorp.com/nomad/docs/drivers/exec
  config {
    command = "[[ var "app_boundary_helper_path" . ]]"

    args = [
      "get-worker-token",
      "--output",
      # TODO: change to `NOMAD_ALLOC_SECRETS_DIR` once available cross-task
      "${NOMAD_ALLOC_DIR}/worker_activation_token",
    ]
  }

  # set `NOMAD_TOKEN` using Workload Identity
  # see https://developer.hashicorp.com/nomad/docs/concepts/workload-identity
  identity {
    env = true
  }

  # see https://developer.hashicorp.com/nomad/docs/job-specification/template
  template {
    change_mode = "restart"

    data = [[ "<<DATA" ]]
      [[ template "boundary_worker_config" . ]]
    [[ "DATA" ]]

    # TODO: change to `NOMAD_ALLOC_SECRETS_DIR` once available cross-task
    destination          = "${NOMAD_ALLOC_DIR}/config.hcl"
    error_on_missing_key = true
  }

  [[ template "environment_variables" . ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/lifecycle#lifecycle-parameters
  lifecycle {
    hook    = "prestart"
    sidecar = false
  }
}

task "register_worker" {
  # see https://developer.hashicorp.com/nomad/docs/drivers/raw_exec
  # and https://developer.hashicorp.com/nomad/docs/drivers/exec
  driver = "[[ var "nomad_task_driver" . ]]"

  [[ template "environment_variables" . ]]

  template {
    destination = "${NOMAD_ALLOC_DIR}/register_worker.sh"

    data = [[ "<<DATA" ]]
      [[ template "boundary_worker_registration" . ]]
    [[ "DATA" ]]
  }

  config {
    command = "${NOMAD_ALLOC_DIR}/register_worker.sh"
  }

  # see https://developer.hashicorp.com/nomad/docs/job-specification/resources
  resources {
    cpu    = 100
    memory = 128
  }

  # see https://developer.hashicorp.com/nomad/docs/job-specification/lifecycle#lifecycle-parameters
  lifecycle {
    hook    = "prestart"
    sidecar = false
  }
}
[[- end ]]
