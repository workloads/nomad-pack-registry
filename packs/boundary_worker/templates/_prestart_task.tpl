[[- define "prestart_task" ]]
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
      "worker",
      "token",
      "--output",
      "${NOMAD_ALLOC_DIR}/worker_activation_token",
    ]
  }

  # set `NOMAD_TOKEN` using Workload Identity
  # see https://developer.hashicorp.com/nomad/docs/concepts/workload-identity
  identity {
    env = true
  }

  [[ template "environment_variables" . ]]

  # see https://developer.hashicorp.com/nomad/docs/job-specification/lifecycle#lifecycle-parameters
  lifecycle {
    hook    = "prestart"
    sidecar = false
  }
}
[[- end ]]
