[[- define "boundary_worker_registration" ]]
#!/bin/sh

WAIT_DURATION="$${WAIT_DURATION:-30}"

sleep_and_wait() {
  while true; do sleep $${WAIT_DURATION}; done
}

# TODO: change to `NOMAD_ALLOC_SECRETS_DIR` once available cross-task
boundary \
  workers \
    create \
      controller-led \
        -token="file://$${NOMAD_ALLOC_DIR}/worker_activation_token" \
        -description="[[ var "app_worker_description" . ]]" \
        -name="{{ env "BOUNDARY_WORKER_NAME" }}"

sleep_and_wait
[[- end ]]
