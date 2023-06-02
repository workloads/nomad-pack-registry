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

    [[ template "group_volumes" .minecraft_java_server.config_mounts ]]

    task [[ template "job_name" .minecraft_java_server.job_name ]] {
      # see https://developer.hashicorp.com/nomad/docs/drivers/docker
      # and https://developer.hashicorp.com/nomad/plugins/drivers/podman
      driver = "[[ .minecraft_java_server.driver ]]"

      config {
        image = "[[ .minecraft_java_server.image.registry ]]/[[ .minecraft_java_server.image.org ]]/[[ .minecraft_java_server.image.slug ]]:[[ .minecraft_java_server.image.tag ]]@[[ .minecraft_java_server.image.digest ]]"

        # see https://docs.minecraft_java_server.io/advanced/cli#configuration-flags-available-at-the-command-line
        # and https://developer.hashicorp.com/nomad/docs/drivers/docker#args
        args = [
          "ALLOW_FLIGHT", [[ .minecraft_java_server.config.allow_flight ]],
          "ALLOW_NETHER", [[ .minecraft_java_server.config.allow_nether ]],
          "ANNOUNCE_PLAYER_ACHIEVEMENTS", [[ .minecraft_java_server.config.announce_player_achievements ]],
          "CONSOLE", [[ .minecraft_java_server.config.console ]],
          "DATA", [[ .minecraft_java_server.config.data | quote ]],
          "DIFFICULTY", [[ .minecraft_java_server.config.difficulty | quote ]],
          "DISABLE_HEALTHCHECK", [[ .minecraft_java_server.config.disable_healthcheck ]],
          "ENABLE_COMMAND_BLOCK", [[ .minecraft_java_server.config.enable_command_block ]],
          "ENABLE_QUERY", [[ .minecraft_java_server.config.enable_query ]],
          "ENABLE_RCON", [[ .minecraft_java_server.config.enable_rcon ]],
          "ENABLE_ROLLING_LOGS", [[ .minecraft_java_server.config.enable_rolling_logs ]],
          "EULA", [[ .minecraft_java_server.config.eula ]],
          "GENERATE_STRUCTURES", [[ .minecraft_java_server.config.generate_structures ]],
          "GUI", [[ .minecraft_java_server.config.gui ]],
          "HARDCORE", [[ .minecraft_java_server.config.hardcore ]],
          "ICON", [[ .minecraft_java_server.config.icon | quote ]],
          "LEVEL_TYPE", [[ .minecraft_java_server.config.level_type | quote ]],
          "MAX_BUILD_HEIGHT", [[ .minecraft_java_server.config.max_build_height ]],
          "MAX_PLAYERS", [[ .minecraft_java_server.config.max_players ]],
          "MAX_TICK_TIME", [[ .minecraft_java_server.config.max_tick_time ]],
          "MAX_WORLD_SIZE", [[ .minecraft_java_server.config.max_world_size ]],
          "MEMORY", [[ .minecraft_java_server.config.memory | quote ]],
          "MODE", [[ .minecraft_java_server.config.mode | quote ]],
          "MODS_FILE", [[ .minecraft_java_server.config.mods_file | quote ]],
          "MOTD", [[ .minecraft_java_server.config.motd | quote ]],
          "ONLINE_MODE", [[ .minecraft_java_server.config.online_mode ]],
          "OVERRIDE_ICON", [[ .minecraft_java_server.config.override_icon ]],
          "PVP", [[ .minecraft_java_server.config.pvp ]],
          "RCON_PASSWORD", [[ .minecraft_java_server.config.rcon_password | quote ]],
          "REMOVE_OLD_MODS", [[ .minecraft_java_server.config.remove_old_mods ]],
          "SEED", [[ .minecraft_java_server.config.seed | quote ]],
          "SERVER_NAME", [[ .minecraft_java_server.config.server_name | quote ]],
          "SNOOPER_ENABLED", [[ .minecraft_java_server.config.snooper_enabled ]],
          "SPAWN_ANIMALS", [[ .minecraft_java_server.config.spawn_animals ]],
          "SPAWN_MONSTERS", [[ .minecraft_java_server.config.spawn_monsters ]],
          "SPAWN_NPCS", [[ .minecraft_java_server.config.spawn_npcs ]],
          "SPAWN_PROTECTION", [[ .minecraft_java_server.config.spawn_protection ]],
          "TZ", [[ .minecraft_java_server.config.tz | quote ]],
          "USE_AIKAR_FLAGS", [[ .minecraft_java_server.config.use_aikar_flags ]],
          "VERSION", [[ .minecraft_java_server.config.version | quote ]],
          "VIEW_DISTANCE", [[ .minecraft_java_server.config.view_distance ]],
          "WORLD", [[ .minecraft_java_server.config.world | quote ]],
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
