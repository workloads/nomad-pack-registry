# minimally viable configuration for a Nomad Server that can run `rcon_web`
# requires `docker` to be installed and running on the host machine

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

  # see https://developer.hashicorp.com/nomad/docs/configuration/client#options-parameters
  options = {
    # see https://developer.hashicorp.com/nomad/docs/configuration/client#driver-allowlist
    "driver.allowlist" = "docker,podman"
  }
}

# see https://developer.hashicorp.com/nomad/docs/drivers/docker
plugin "docker" {
  # see https://developer.hashicorp.com/nomad/docs/drivers/docker#allow_privileged
  allow_privileged = false

  # see https://developer.hashicorp.com/nomad/docs/drivers/docker#plugin-options
  config {
    # see https://developer.hashicorp.com/nomad/docs/drivers/docker#extra_labels
    extra_labels = [
      "nomad_job_name",
      "job_id",
      "task_name",
    ]

    # see https://developer.hashicorp.com/nomad/docs/drivers/docker#gc
    gc {
      image       = true
      image_delay = "3m"
      container   = true

      dangling_containers {
        enabled        = true
        dry_run        = false
        period         = "5m"
        creation_grace = "5m"
      }
    }

    # see https://developer.hashicorp.com/nomad/docs/drivers/docker#volumes-1
    volumes {
      enabled = true
    }
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
    text             = "⚠️ Testing Environment for the `rcon_web` Nomad Pack."
    background_color = "#00000"
    text_color       = "#ffffff"
  }
}
