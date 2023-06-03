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

      [[ template "service_checks" .minecraft_java_server.ports ]]
    }
    [[ end -]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/restart
    restart {
      attempts = 3
      interval = "60s"
      delay    = "15s"
      mode     = "fail"
    }

    [[ template "group_volumes" .minecraft_java_server.volumes ]]

    task [[ template "job_name" .minecraft_java_server.job_name ]] {
      # see https://developer.hashicorp.com/nomad/docs/drivers/docker
      # and https://developer.hashicorp.com/nomad/plugins/drivers/podman
      driver = "[[ .minecraft_java_server.driver ]]"

      config {
        image = "[[ .minecraft_java_server.image.registry ]]/[[ .minecraft_java_server.image.namespace ]]/[[ .minecraft_java_server.image.image ]]:[[ .minecraft_java_server.image.tag ]]@[[ .minecraft_java_server.image.digest ]]"

        # see https://docs.minecraft_java_server.io/advanced/cli#configuration-flags-available-at-the-command-line
        # and https://developer.hashicorp.com/nomad/docs/drivers/docker#args
        args = [
          "ALLOW_FLIGHT=[[ .minecraft_java_server.config.allow_flight | toString | upper ]]",
          "ALLOW_NETHER=[[ .minecraft_java_server.config.allow_nether | toString | upper ]]",
          "ANNOUNCE_PLAYER_ACHIEVEMENTS=[[ .minecraft_java_server.config.announce_player_achievements | toString | upper ]]",
          "CONSOLE=[[ .minecraft_java_server.config.console | toString | upper ]]",
          "DATA=[[ .minecraft_java_server.config.data | squote ]]",
          "DIFFICULTY=[[ .minecraft_java_server.config.difficulty | squote ]]",
          "DISABLE_HEALTHCHECK=[[ .minecraft_java_server.config.disable_healthcheck | toString | upper ]]",
          "ENABLE_COMMAND_BLOCK=[[ .minecraft_java_server.config.enable_command_block | toString | upper ]]",
          "ENABLE_QUERY=[[ .minecraft_java_server.config.enable_query | toString | upper ]]",
          "ENABLE_RCON=[[ .minecraft_java_server.config.enable_rcon | toString | upper ]]",
          "ENABLE_ROLLING_LOGS=[[ .minecraft_java_server.config.enable_rolling_logs | toString | upper]]",
          "EULA=[[ .minecraft_java_server.config.eula | toString | upper ]]",
          "GENERATE_STRUCTURES=[[ .minecraft_java_server.config.generate_structures | toString | upper ]]",
          "GUI=[[ .minecraft_java_server.config.gui | toString | upper ]]",
          "HARDCORE=[[ .minecraft_java_server.config.hardcore | toString | upper ]]",
          "ICON=[[ .minecraft_java_server.config.icon | squote ]]",
          "LEVEL_TYPE=[[ .minecraft_java_server.config.level_type | squote ]]",
          "MAX_BUILD_HEIGHT=[[ .minecraft_java_server.config.max_build_height ]]",
          "MAX_PLAYERS=[[ .minecraft_java_server.config.max_players ]]",
          "MAX_TICK_TIME=[[ .minecraft_java_server.config.max_tick_time ]]",
          "MAX_WORLD_SIZE=[[ .minecraft_java_server.config.max_world_size ]]",
          "MEMORY=[[ .minecraft_java_server.config.memory | squote ]]",
          "MODE=[[ .minecraft_java_server.config.mode | squote ]]",
          "MODS_FILE=[[ .minecraft_java_server.config.mods_file | squote ]]",
          "MOTD=[[ .minecraft_java_server.config.motd | squote ]]",
          "ONLINE_MODE=[[ .minecraft_java_server.config.online_mode | toString | upper ]]",
          "OVERRIDE_ICON=[[ .minecraft_java_server.config.override_icon | toString | upper ]]",
          "PVP=[[ .minecraft_java_server.config.pvp | toString | upper ]]",
          "RCON_PASSWORD=[[ .minecraft_java_server.config.rcon_password | squote ]]",
          "REMOVE_OLD_MODS=[[ .minecraft_java_server.config.remove_old_mods | toString | upper ]]",
          "SEED=[[ .minecraft_java_server.config.seed | squote ]]",
          "SERVER_NAME=[[ .minecraft_java_server.config.server_name | squote ]]",
          "SNOOPER_ENABLED=[[ .minecraft_java_server.config.snooper_enabled | toString | upper ]]",
          "SPAWN_ANIMALS=[[ .minecraft_java_server.config.spawn_animals | toString | upper ]]",
          "SPAWN_MONSTERS=[[ .minecraft_java_server.config.spawn_monsters | toString | upper ]]",
          "SPAWN_NPCS=[[ .minecraft_java_server.config.spawn_npcs | toString | upper ]]",
          "SPAWN_PROTECTION=[[ .minecraft_java_server.config.spawn_protection | squote ]]",
          "TZ=[[ .minecraft_java_server.config.tz | squote ]]",
          "USE_AIKAR_FLAGS=[[ .minecraft_java_server.config.use_aikar_flags | toString | upper ]]",
          "VERSION=[[ .minecraft_java_server.config.version | squote ]]",
          "VIEW_DISTANCE=[[ .minecraft_java_server.config.view_distance ]]",
          "WORLD=[[ .minecraft_java_server.config.world | squote ]]",
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
