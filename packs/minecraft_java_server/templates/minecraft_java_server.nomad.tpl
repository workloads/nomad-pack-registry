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
      provider = "consul"

      [[ template "service_checks" .minecraft_java_server.ports ]]
    }
    [[ end -]]

    # see https://developer.hashicorp.com/nomad/docs/job-specification/restart
    restart {
      attempts = 3
      interval = "120s"
      delay    = "30s"
      mode     = "fail"
    }

    [[ template "group_volumes" .minecraft_java_server.volumes ]]

    task [[ template "job_name" .minecraft_java_server.job_name ]] {
      driver = "[[ .minecraft_java_server.driver ]]"

      config {
        image = "[[ .minecraft_java_server.image.registry ]]/[[ .minecraft_java_server.image.namespace ]]/[[ .minecraft_java_server.image.image ]]:[[ .minecraft_java_server.image.tag ]]@[[ .minecraft_java_server.image.digest ]]"

        [[ template "task_ports" .minecraft_java_server.config_ports ]]
      }

      env {
        ALLOW_FLIGHT                 = [[ .minecraft_java_server.config.allow_flight | toString | upper | quote ]]
        ALLOW_NETHER                 = [[ .minecraft_java_server.config.allow_nether | toString | upper | quote ]]
        ANNOUNCE_PLAYER_ACHIEVEMENTS = [[ .minecraft_java_server.config.announce_player_achievements | toString | upper | quote ]]
        CONSOLE                      = [[ .minecraft_java_server.config.console | toString | upper | quote ]]
        DATA                         = [[ .minecraft_java_server.config.data | quote ]]
        DIFFICULTY                   = [[ .minecraft_java_server.config.difficulty | quote ]]
        DISABLE_HEALTHCHECK          = [[ .minecraft_java_server.config.disable_healthcheck | toString | upper | quote ]]
        ENABLE_COMMAND_BLOCK         = [[ .minecraft_java_server.config.enable_command_block | toString | upper | quote ]]
        ENABLE_QUERY                 = [[ .minecraft_java_server.config.enable_query | toString | upper | quote ]]
        ENABLE_RCON                  = [[ .minecraft_java_server.config.enable_rcon | toString | upper | quote ]]
        ENABLE_ROLLING_LOGS          = [[ .minecraft_java_server.config.enable_rolling_logs | toString | upper]]
        EULA                         = [[ .minecraft_java_server.config.eula | toString | upper | quote ]]
        GENERATE_STRUCTURES          = [[ .minecraft_java_server.config.generate_structures | toString | upper | quote ]]
        GUI                          = [[ .minecraft_java_server.config.gui | toString | upper | quote ]]
        HARDCORE                     = [[ .minecraft_java_server.config.hardcore | toString | upper | quote ]]
        ICON                         = [[ .minecraft_java_server.config.icon | quote ]]
        LEVEL_TYPE                   = [[ .minecraft_java_server.config.level_type | quote ]]
        MAX_BUILD_HEIGHT             = [[ .minecraft_java_server.config.max_build_height ]]
        MAX_PLAYERS                  = [[ .minecraft_java_server.config.max_players ]]
        MAX_TICK_TIME                = [[ .minecraft_java_server.config.max_tick_time ]]
        MAX_WORLD_SIZE               = [[ .minecraft_java_server.config.max_world_size ]]
        MEMORY                       = [[ .minecraft_java_server.config.memory | quote ]]
        MODE                         = [[ .minecraft_java_server.config.mode | quote ]]
        MODS_FILE                    = [[ .minecraft_java_server.config.mods_file | quote ]]
        MOTD                         = [[ .minecraft_java_server.config.motd | quote ]]
        ONLINE_MODE                  = [[ .minecraft_java_server.config.online_mode | toString | upper | quote ]]
        OVERRIDE_ICON                = [[ .minecraft_java_server.config.override_icon | toString | upper | quote ]]
        PVP                          = [[ .minecraft_java_server.config.pvp | toString | upper | quote ]]
        RCON_PASSWORD                = [[ .minecraft_java_server.config.rcon_password | quote ]]
        REMOVE_OLD_MODS              = [[ .minecraft_java_server.config.remove_old_mods | toString | upper | quote ]]
        SEED                         = [[ .minecraft_java_server.config.seed | quote ]]
        SERVER_NAME                  = [[ .minecraft_java_server.config.server_name | quote ]]
        SNOOPER_ENABLED              = [[ .minecraft_java_server.config.snooper_enabled | toString | upper | quote ]]
        SPAWN_ANIMALS                = [[ .minecraft_java_server.config.spawn_animals | toString | upper | quote ]]
        SPAWN_MONSTERS               = [[ .minecraft_java_server.config.spawn_monsters | toString | upper | quote ]]
        SPAWN_NPCS                   = [[ .minecraft_java_server.config.spawn_npcs | toString | upper | quote ]]
        SPAWN_PROTECTION             = [[ .minecraft_java_server.config.spawn_protection | quote ]]
        TZ                           = [[ .minecraft_java_server.config.tz | quote ]]
        TYPE                         = [[ .minecraft_java_server.config.type | quote ]]
        USE_AIKAR_FLAGS              = [[ .minecraft_java_server.config.use_aikar_flags | toString | upper | quote ]]
        VERSION                      = [[ .minecraft_java_server.config.version | quote ]]
        VIEW_DISTANCE                = [[ .minecraft_java_server.config.view_distance ]]
        WORLD                        = [[ .minecraft_java_server.config.world | quote ]]
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
