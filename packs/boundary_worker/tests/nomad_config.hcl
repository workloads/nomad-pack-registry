# minimally viable configuration for a Nomad Server that can run `boundary_worker`

# see https://developer.hashicorp.com/nomad/docs/configuration#data_dir
data_dir = "/tmp/"

# see https://developer.hashicorp.com/nomad/docs/configuration#datacenter
datacenter = "testing"

# see https://developer.hashicorp.com/nomad/docs/configuration#region
region = "global"

# see https://developer.hashicorp.com/nomad/docs/configuration/acl
acl {
  # testing this Pack does not require ACLs to be enabled
  enabled = false
}

# see https://developer.hashicorp.com/nomad/docs/configuration/client
client {
  enabled = true

  # see https://developer.hashicorp.com/nomad/docs/configuration/client#network_interface
  network_interface = "{{ GetDefaultInterfaces | attr \"name\" }}"

  # see https://developer.hashicorp.com/nomad/docs/configuration/client#options-parameters
  options = {
    # see https://developer.hashicorp.com/nomad/docs/configuration/client#driver-allowlist
    "driver.allowlist" = "raw_exec"
  }
}

# see https://developer.hashicorp.com/nomad/docs/drivers/exec#plugin-options
plugin "raw_exec" {
  config {
    enabled = true
  }
}

# see https://developer.hashicorp.com/nomad/docs/configuration/server
server {
  enabled          = true
  bootstrap_expect = 1
}

# see https://developer.hashicorp.com/nomad/docs/configuration/telemetry
telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
}

# see https://developer.hashicorp.com/nomad/docs/configuration/ui
ui {
  enabled = true

  # see https://developer.hashicorp.com/nomad/docs/configuration/ui#label-parameters
  label {
    text             = "⚠️ Testing Environment for the `boundary_worker` Nomad Pack."
    background_color = "#00000"
    text_color       = "#ffffff"
  }
}
