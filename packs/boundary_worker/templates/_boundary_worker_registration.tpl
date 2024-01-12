[[- define "boundary_worker_registration" ]]
#!/bin/sh

WAIT_DURATION="$${WAIT_DURATION:-30}"

sleep_and_wait() {
  while true; do sleep ${WAIT_DURATION}; done
}

# TODO: change to `NOMAD_ALLOC_SECRETS_DIR` once available cross-task
# TODO: make `name` be defined in a central place
boundary \
  workers \
    create \
      controller-led \
        -token="file://{{ env "NOMAD_ALLOC_DIR" }}/worker_activation_token" \
        -description="[[ var "app_worker_description" . ]]" \
        -name="[[ var "app_worker_name_prefix" . | replace "_" "-" | lower ]]-{{ env "NOMAD_SHORT_ALLOC_ID" }}-{{ env "NOMAD_ALLOC_INDEX" }}"

sleep_and_wait
[[- end ]]
