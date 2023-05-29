# minimally viable configuration for a Nomad Server that can run `minecraft_java_server`
# requires `docker` to be installed and running on the host machine

# see https://developer.hashicorp.com/nomad/docs/configuration#data_dir
data_dir = "/tmp/"

# see https://developer.hashicorp.com/nomad/docs/configuration#datacenter
datacenter = "testing"

# see https://developer.hashicorp.com/nomad/docs/configuration#region
region = "global"

# see https://developer.hashicorp.com/nomad/docs/configuration/client
client {
  enabled = true

  # see https://developer.hashicorp.com/nomad/docs/configuration/client#host_volume
  host_volume "minecraft_data" {
    path      = "/tmp/minecraft_data"
    read_only = false
  }

  # see https://developer.hashicorp.com/nomad/docs/configuration/client#host_volume
  host_volume "minecraft_extras" {
    path      = "/tmp/minecraft_extras"
    read_only = false
  }

  host_volume "minecraft_worlddata" {
    path      = "/tmp/minecraft_worlds"
    read_only = true
  }
}

# see https://developer.hashicorp.com/nomad/docs/drivers/docker
plugin "docker" {
  allow_privileged = true

  config {
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
    text             = "⚠️ Testing Environment for the `minecraft_java_server` Nomad Pack."
    background_color = "#00000"
    text_color       = "#ffffff"
  }
}
