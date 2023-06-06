job [[ template "job_name" .minecraft_java_edition.job_name ]] {
  [[ template "region" .minecraft_java_edition.region ]]
  datacenters = [[ .minecraft_java_edition.datacenters | toJson ]]
  type        = "service"
  namespace   = [[ .minecraft_java_edition.namespace | quote ]]
  priority    = [[ .minecraft_java_edition.priority ]]

  group [[ template "job_name" .minecraft_java_edition.job_name ]] {
    count = [[ .minecraft_java_edition.count ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
    ephemeral_disk {
      migrate = [[ .minecraft_java_edition.ephemeral_disk.migrate ]]
      size    = [[ .minecraft_java_edition.ephemeral_disk.size ]]
      sticky  = [[ .minecraft_java_edition.ephemeral_disk.sticky ]]
    }

    # see https://developer.hashicorp.com/nomad/docs/job-specification/network
    network {
      # see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
      mode = [[ .minecraft_java_edition.network_mode | quote ]]
      [[ template "network_ports" .minecraft_java_edition ]]
    }

    [[- template "service" .minecraft_java_edition ]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/restart
    restart {
      attempts = 3
      interval = "120s"
      delay    = "30s"
      mode     = "fail"
    }

    [[ template "group_volumes" .minecraft_java_edition.volumes ]]

    task [[ template "job_name" .minecraft_java_edition.job_name ]] {
      driver = [[ .minecraft_java_edition.driver | quote ]]

      config {
        image = "[[ .minecraft_java_edition.image.registry ]]/[[ .minecraft_java_edition.image.namespace ]]/[[ .minecraft_java_edition.image.image ]]:[[ .minecraft_java_edition.image.tag ]]@[[ .minecraft_java_edition.image.digest ]]"

        [[ template "task_ports" .minecraft_java_edition ]]
      }

      env {
        ALLOW_FLIGHT                 = [[ .minecraft_java_edition.config.allow_flight | toString | upper | quote ]]
        ALLOW_NETHER                 = [[ .minecraft_java_edition.config.allow_nether | toString | upper | quote ]]
        ANNOUNCE_PLAYER_ACHIEVEMENTS = [[ .minecraft_java_edition.config.announce_player_achievements | toString | upper | quote ]]
        CONSOLE                      = [[ .minecraft_java_edition.config.console | toString | upper | quote ]]
        DATA                         = [[ .minecraft_java_edition.config.data | quote ]]
        DIFFICULTY                   = [[ .minecraft_java_edition.config.difficulty | quote ]]
        DISABLE_HEALTHCHECK          = [[ .minecraft_java_edition.config.disable_healthcheck | toString | upper | quote ]]
        ENABLE_COMMAND_BLOCK         = [[ .minecraft_java_edition.config.enable_command_block | toString | upper | quote ]]
        ENABLE_QUERY                 = [[ .minecraft_java_edition.config.enable_query | toString | upper | quote ]]
        ENABLE_RCON                  = [[ .minecraft_java_edition.config.enable_rcon | toString | upper | quote ]]
        ENABLE_ROLLING_LOGS          = [[ .minecraft_java_edition.config.enable_rolling_logs | toString | upper | quote ]]
        EULA                         = [[ .minecraft_java_edition.config.eula | toString | upper | quote ]]
        GENERATE_STRUCTURES          = [[ .minecraft_java_edition.config.generate_structures | toString | upper | quote ]]
        GUI                          = [[ .minecraft_java_edition.config.gui | toString | upper | quote ]]
        HARDCORE                     = [[ .minecraft_java_edition.config.hardcore | toString | upper | quote ]]
        ICON                         = [[ .minecraft_java_edition.config.icon | quote ]]
        LEVEL_TYPE                   = [[ .minecraft_java_edition.config.level_type | quote ]]
        MAX_BUILD_HEIGHT             = [[ .minecraft_java_edition.config.max_build_height ]]
        MAX_MEMORY                   = [[ .minecraft_java_edition.config.max_memory | quote ]]
        MAX_PLAYERS                  = [[ .minecraft_java_edition.config.max_players ]]
        MAX_TICK_TIME                = [[ .minecraft_java_edition.config.max_tick_time ]]
        MAX_WORLD_SIZE               = [[ .minecraft_java_edition.config.max_world_size ]]
        MEMORY                       = [[ .minecraft_java_edition.config.memory | quote ]]
        MODE                         = [[ .minecraft_java_edition.config.mode | quote ]]
        MODS_FILE                    = [[ .minecraft_java_edition.config.mods_file | quote ]]
        MOTD                         = [[ .minecraft_java_edition.config.motd | quote ]]
        ONLINE_MODE                  = [[ .minecraft_java_edition.config.online_mode | toString | upper | quote ]]
        OVERRIDE_ICON                = [[ .minecraft_java_edition.config.override_icon | toString | upper | quote ]]
        PVP                          = [[ .minecraft_java_edition.config.pvp | toString | upper | quote ]]
        RCON_PASSWORD                = [[ .minecraft_java_edition.config.rcon_password | quote ]]
        REMOVE_OLD_MODS              = [[ .minecraft_java_edition.config.remove_old_mods | toString | upper | quote ]]
        SEED                         = [[ .minecraft_java_edition.config.seed | quote ]]
        SERVER_NAME                  = [[ .minecraft_java_edition.config.server_name | quote ]]
        SNOOPER_ENABLED              = [[ .minecraft_java_edition.config.snooper_enabled | toString | upper | quote ]]
        SPAWN_ANIMALS                = [[ .minecraft_java_edition.config.spawn_animals | toString | upper | quote ]]
        SPAWN_MONSTERS               = [[ .minecraft_java_edition.config.spawn_monsters | toString | upper | quote ]]
        SPAWN_NPCS                   = [[ .minecraft_java_edition.config.spawn_npcs | toString | upper | quote ]]
        SPAWN_PROTECTION             = [[ .minecraft_java_edition.config.spawn_protection | quote ]]
        TZ                           = [[ .minecraft_java_edition.config.tz | quote ]]
        TYPE                         = [[ .minecraft_java_edition.config.type | quote ]]
        USE_AIKAR_FLAGS              = [[ .minecraft_java_edition.config.use_aikar_flags | toString | upper | quote ]]
        VERSION                      = [[ .minecraft_java_edition.config.version | quote ]]
        VIEW_DISTANCE                = [[ .minecraft_java_edition.config.view_distance ]]
        WORLD                        = [[ .minecraft_java_edition.config.world | quote ]]
      }

      [[ template "task_volume_mounts" .minecraft_java_edition.volumes ]]

      # see https://developer.hashicorp.com/nomad/docs/job-specification/resources
      resources {
        cpu    = [[ .minecraft_java_edition.resources.cpu ]]
        memory = [[ .minecraft_java_edition.resources.memory ]]
      }
    }
  }
}
