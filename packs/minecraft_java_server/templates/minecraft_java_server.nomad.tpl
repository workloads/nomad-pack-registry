job [[ template "job_name" .minecraft_java_server.job_name ]] {
  [[ template "region" .minecraft_java_server.region ]]
  datacenters = [[ .minecraft_java_server.datacenters | toJson ]]
  type        = "service"
  namespace   = [[ .minecraft_java_server.namespace | quote ]]
  priority    = [[ .minecraft_java_server.priority ]]

  group [[ template "job_name" .minecraft_java_server.job_name ]] {
    count = [[ .minecraft_java_server.count ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
    ephemeral_disk {
      migrate = [[ .minecraft_java_server.ephemeral_disk.migrate ]]
      size    = [[ .minecraft_java_server.ephemeral_disk.size ]]
      sticky  = [[ .minecraft_java_server.ephemeral_disk.sticky ]]
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/network
    network {
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
      mode = "host"
      [[ template "network_ports" .minecraft_java_server.config_ports ]]
    }

    [[ if .minecraft_java_server.register_consul_service ]]
    # see https://developer.hashicorp.com/nomad/docs/job-specification/service
    service {
      name     = "[[ .minecraft_java_server.consul_service_name ]]"
      tags     =  [[ .minecraft_java_server.consul_service_tags | toJson ]]
      port     = "main"
      provider = "nomad"

      [[ template "service_checks" .minecraft_java_server.config_ports ]]
    }
    [[ end -]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/restart
    restart {
      attempts = 3
      interval = "1m"
      delay    = "10s"
      mode     = "fail"
    }

    [[- template "group_volumes" .minecraft_java_server.config_mounts ]]

    task [[ template "job_name" .minecraft_java_server.job_name ]] {
      # see https://developer.hashicorp.com/nomad/docs/drivers/docker
      driver = "[[ .minecraft_java_server.driver ]]"

      config {
        image = "[[ .minecraft_java_server.image.registry ]]/[[ .minecraft_java_server.image.org ]]/[[ .minecraft_java_server.image.slug ]]:[[ .minecraft_java_server.image.tag ]]@[[ .minecraft_java_server.image.digest ]]"

        # see https://docs.minecraft_java_server.io/advanced/cli#configuration-flags-available-at-the-command-line
        # and https://developer.hashicorp.com/nomad/docs/drivers/docker#args
        args = [
          "--data", [[ .minecraft_java_server.config_mounts.data.destination | quote ]],

          #- template "arg_logo" .minecraft_java_server.config -]]
        ]

        [[ template "task_ports" .minecraft_java_server.config_ports ]]
      }

      [[ template "task_volume_mounts" .minecraft_java_server.config_mounts ]]

      # see https://developer.hashicorp.com/nomad/docs/job-specification/resources
      resources {
        cpu    = [[ .minecraft_java_server.resources.cpu ]]
        memory = [[ .minecraft_java_server.resources.memory ]]
      }
    }
  }
}
