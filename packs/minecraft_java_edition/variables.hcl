variable "app_allow_flight" {
  type        = bool
  description = "Toggle to enable PC flight."
  default     = true
}

variable "app_allow_nether" {
  type        = bool
  description = "Toggle to enable The Nether."
  default     = false
}

variable "app_announce_player_achievements" {
  type        = bool
  description = "Toggle to enable Player Achievement Announcements."
  default     = false
}

variable "app_console" {
  type        = bool
  description = "Toggle to enable Console."
  default     = true
}

variable "app_data" {
  type        = string
  description = "Directory for Application Data."
  default     = "/data"
}

variable "app_difficulty" {
  type        = string
  description = "Difficulty Level (e.g.: `peaceful`, `easy`, `normal`, `hard`)."
  default     = "peaceful"
}

variable "app_disable_healthcheck" {
  type        = bool
  description = "Toggle to disable Container Health Check."
  default     = false
}

variable "app_enable_command_block" {
  type        = bool
  description = "Toggle to enable Command Blocks."
  default     = true
}

variable "app_enable_query" {
  type        = bool
  description = "Toggle to enable Gamespy Query Protocol."
  default     = false
}

variable "app_enable_rcon" {
  type        = bool
  description = "Toggle to enable RCON interface."
  default     = true
}

variable "app_enable_rolling_logs" {
  type        = bool
  description = "Toggle to enable Log Rolling."
  default     = true
}

variable "app_eula" {
  type        = bool
  description = "Toggle to accept End-User License Agreement."
  default     = true
}

variable "app_force_redownload" {
  type        = bool
  description = "Toggle to force redownloading of Server (JAR) File."
  default     = false
}

variable "app_force_world_copy" {
  type        = bool
  description = "Toggle to force copying of World Data."

  # setting this to `true` is a destructive action that will overwrite existing World Data
  default = false
}

variable "app_generate_structures" {
  type        = bool
  description = "Toggle to pre-generate Structures (e.g.: Villages, Outposts)."
  default     = true
}

variable "app_gui" {
  type        = bool
  description = "Toggle to enable GUI."
  default     = true
}

variable "app_hardcore" {
  type        = bool
  description = "Toggle to enable Hardcore Mode."
  default     = false
}

variable "app_icon" {
  type        = string
  description = "Server Icon."
  default     = "https://assets.workloads.io/minecraft/server-icons/command-block.png"
}

variable "app_level_type" {
  type        = string
  description = "Level Type (e.g.: `normal`, `flat`)."
  default     = "normal"
}

variable "app_log_timestamp" {
  type        = bool
  description = "Togggle to include Timestamp in Log Messages."
  default     = true
}

variable "app_max_build_height" {
  type        = number
  description = "Maximum allowed Building Height (in blocks)."
  default     = 256
}

variable "app_max_memory" {
  type        = string
  description = "Maximum allowed Memory."
  default     = "4G" # 100% of `resources.memory`
}

variable "app_max_players" {
  type        = number
  description = "Maximum Player Count."
  default     = 20
}

variable "app_max_tick_time" {
  type        = number
  description = "Maximum time a Tick may take before Watchdog responds (in msec)."
  default     = 60000
}

variable "app_max_world_size" {
  type        = number
  description = "Maximum Radius of World (in blocks)."
  default     = 10000
}

variable "app_memory" {
  type        = string
  description = "Initial Memory."
  default     = "3G" # 75% of `resources.memory`
}

variable "app_mode" {
  type        = string
  description = "Game Mode."
  default     = "creative"
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/mods-and-plugins/#modplugin-url-listing-file
variable "app_mods_file" {
  type        = string
  description = "Path to file with Mod URLs (e.g.: `/extras/mods.txt`)"
  default     = "https://assets.workloads.io/minecraft/mods/base/mods.txt"
}

variable "app_motd" {
  type        = string
  description = "Message of the Day."

  # this value supports Formatting codes, see https://minecraft.wiki/w/Formatting_codes
  default = "This Server is running on §2§lHashiCorp Nomad§r!"
}

variable "app_online_mode" {
  type        = bool
  description = "Toggle to enable Account Authentication (with Minecraft.net / Microsoft Account)."
  default     = false
}

variable "app_override_icon" {
  type        = bool
  description = "Toggle to allow overriding Server Icon."
  default     = true
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/mods-and-plugins/#modplugin-url-listing-file
variable "app_plugins_file" {
  type        = string
  description = "Path to file with Plugin URLs (e.g.: `/extras/plugins.txt`)"
  default     = ""
}

variable "app_pvp" {
  type        = bool
  description = "Toggle to enable PvP Damage."
  default     = false
}

variable "app_rcon_password" {
  type        = string
  description = "RCON Interface Password."
  default     = "AW96B6"
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/server-properties/#custom-server-resource-pack
variable "app_resource_pack" {
  type        = string
  description = "URL to Resource Pack (in ZIP format)."
  default     = ""
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/server-properties/#custom-server-resource-pack
variable "app_resource_pack_sha1" {
  type        = string
  description = "SHA1 Checksum for Resource Pack."
  default     = ""
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/auto-rcon-commands/#auto-execute-rcon-commands
variable "app_rcon_cmds_connect" {
  type        = list(string)
  description = "RCON Commands to run on Client Connect."
  default     = []
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/auto-rcon-commands/#auto-execute-rcon-commands
variable "app_rcon_cmds_connect" {
  type        = list(string)
  description = "RCON Commands to run on (any) Client Connect."
  default     = []
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/auto-rcon-commands/#auto-execute-rcon-commands
variable "app_rcon_cmds_first_connect" {
  type        = list(string)
  description = "RCON Commands to run on first Client Connect."
  default     = []
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/auto-rcon-commands/#auto-execute-rcon-commands
variable "app_rcon_cmds_disconnect" {
  type        = list(string)
  description = "RCON Commands to run on (any) Client Disconnect."
  default     = []
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/auto-rcon-commands/#auto-execute-rcon-commands
variable "app_rcon_cmds_last_disconnect" {
  type        = list(string)
  description = "RCON Commands to run on last Client Disconnect."
  default     = []
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/auto-rcon-commands/#auto-execute-rcon-commands
variable "app_rcon_cmds_startup" {
  type        = list(string)
  description = "RCON Commands to run on Server start up."
  default     = []
}

variable "app_remove_old_mods" {
  type        = bool
  description = "Toggle to enable removal of old Mod Data Files."
  default     = true
}

variable "app_seed" {
  type        = string
  description = "Level Seed."

  # see https://www.reddit.com/r/minecraftseeds/ for inspiration

  default = ""

  # big cave system with ancient city
  # default = "5379859465535818918"

  # cherry grove near spawn
  # default = "416514620"

  # water-heavy and islands
  #default = "-5709450962299196479"
}

variable "app_server_name" {
  type        = string
  description = "Server Name."
  default     = "Minecraft Java Edition Server"
}

variable "app_snooper_enabled" {
  type        = bool
  description = "Toggle to enable sending updates to `snoop.minecraft.net`."
  default     = false
}

variable "app_spawn_animals" {
  type        = bool
  description = "Toggle to enable Animals to spawn."
  default     = true
}

variable "app_spawn_monsters" {
  type        = bool
  description = "Toggle to enable Monsters to spawn."
  default     = true
}

variable "app_spawn_npcs" {
  type        = bool
  description = "Toggle to enable NPCs to spawn."
  default     = true
}

variable "app_spawn_protection" {
  type        = number
  description = "Sets area that non-ops cannot alter (in blocks)."
  default     = 0
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/misc-options/#stop-duration
variable "app_stop_duration" {
  type        = number
  description = "Time (in seconds) the Minecraft Process Wrapper will wait for processes to gradually finish."
  default     = 120
}

# see https://docker-minecraft-server.readthedocs.io/en/latest/configuration/misc-options/#server-shutdown-options
variable "app_stop_server_announce_delay" {
  type        = number
  description = "Time (in seconds) Players are allowed to finish activities until Server shuts down."
  default     = 60
}

variable "app_type" {
  type        = string
  description = "Server Type (e.g.: `vanilla`, `fabric`, etc.)."
  default     = "fabric"
}

variable "app_tz" {
  type        = string
  description = "Timezone."
  default     = "Europe/Amsterdam"
}

variable "app_use_aikar_flags" {
  type        = bool
  description = "Toggle to enable optimized JVM flags for GC tuning."
  default     = true
}

# see https://minecraft.wiki/w/Category:Java_Edition_versions
variable "app_version" {
  type        = string
  description = "Minecraft Version."
  default     = "1.20.1"
}

variable "app_view_distance" {
  type        = number
  description = "Amount of World Data to send to define viewing distance (in blocks)."
  default     = 32
}

variable "app_world" {
  type        = string
  description = "World Data."
  default     = "https://assets.workloads.io/minecraft/worlds/world-of-worlds.zip"
}

###############################
## Pack-specifc Configuration #
###############################

variable "nomad_pack_verbose_output" {
  type        = bool
  description = "Toggle to enable verbose output."
  default     = true
}

#####################################
## Nomad Job-specific Configuration #
#####################################

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#datacenters
variable "nomad_job_datacenters" {
  type        = list(string)
  description = "Eligible Datacenters for the Job."

  default = [
    "*"
  ]
}

variable "nomad_job_name" {
  type        = string
  description = "Name for the Job."

  # value will be truncated to 63 characters when necessary
  default = "minecraft"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#namespace
variable "nomad_job_namespace" {
  type        = string
  description = "Namespace for the Job."
  default     = "default"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#priority
variable "nomad_job_priority" {
  type        = number
  description = "Priority for the Job."
  default     = 99
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#regions
variable "nomad_job_region" {
  type        = string
  description = "Region for the Job."
  default     = "global"
}

variable "nomad_group_count" {
  type        = number
  description = "Count of Deployments for the Group."
  default     = 1
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
variable "nomad_group_ephemeral_disk" {
  type = object({
    migrate = bool
    size    = number
    sticky  = bool
  })

  description = "Ephemeral Disk Configuration for the Group."

  default = {
    # make best-effort attempt to migrate data to a different node if no placement is possible on the original node.
    migrate = true

    # size of the ephemeral disk in MB
    size = 1024

    # make best-effort attempt to place an updated allocation on the same node.
    sticky = true
  }
}

variable "nomad_group_name" {
  type        = string
  description = "Name for the Group."
  default     = "minecraft"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
variable "nomad_group_network_mode" {
  type        = string
  description = "Network Mode for the Group."
  default     = "host"
}

variable "nomad_group_ports" {
  type = map(object({
    check_interval = string
    check_timeout  = string
    host_network   = string
    method         = string
    omit_check     = bool
    path           = string
    port           = number
    type           = string
  }))

  description = "Port Configuration for the Group."

  default = {
    # port for Minecraft server
    main = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = null
      omit_check     = false
      path           = null
      port           = 25565
      type           = "tcp"
    },

    # port for RCON Interface
    # ⚠️ `rcon` is a magic name that is used to trigger certain logic inside `pack.nomad.tpl`
    rcon = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = null
      omit_check     = false
      path           = null
      port           = 25575
      type           = "tcp"
    },

    # port for Prometheus Exporter Interface
    # requires https://modrinth.com/mod/fabricexporter to be loaded as part of the server's mods
    prometheus = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = null
      omit_check     = false
      path           = "/"
      port           = 25585
      type           = "http"
    },

    # port for BlueMap Interface
    # requires https://modrinth.com/plugin/bluemap to be loaded as part of the server's mods
    bluemap = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = null
      omit_check     = false
      path           = "/"
      port           = 25595
      type           = "http"
    },
  }
}

variable "nomad_group_restart_logic" {
  type = object({
    attempts = number
    interval = string
    delay    = string
    mode     = string
  })

  description = "Restart Logic for the Group."

  default = {
    attempts = 3
    interval = "120s"
    delay    = "30s"
    mode     = "fail"
  }
}

variable "nomad_group_service_name_prefix" {
  type        = string
  description = "Name of the Service for the Group."
  default     = "minecraft"
}

variable "nomad_group_service_provider" {
  type        = string
  description = "Provider of the Service for the Group."
  default     = "nomad"
}

variable "nomad_group_tags" {
  type        = list(string)
  description = "List of Tags for the Group."

  default = [
    "minecraft",
    "minecraft-java-edition"
  ]
}

variable "nomad_group_volumes" {
  type = map(object({
    name        = string
    type        = string
    destination = string
    read_only   = bool
  }))

  description = "Volumes for the Group."

  default = {
    minecraft_data = {
      name        = "minecraft_data",
      type        = "host"
      destination = "/data"
      read_only   = false
    },

    minecraft_extras = {
      name        = "minecraft_extras",
      type        = "host"
      destination = "/extras"
      read_only   = false
    },

    minecraft_worlds = {
      name        = "minecraft_worlds",
      type        = "host"
      destination = "/worlds"
      read_only   = false
    },
  }
}

variable "nomad_task_driver" {
  type        = string
  description = "Driver to use for the Task."
  default     = "docker"
}

variable "nomad_task_image" {
  type = object({
    registry  = string
    namespace = string
    image     = string
    tag       = string
    digest    = string
  })

  description = "Content Address to use for the Container Image for the Task."

  # see https://hub.docker.com/r/itzg/minecraft-server/tags
  default = {
    # Container Registry URL where the Image is hosted
    registry = "index.docker.io"

    # Namespace of the Image
    namespace = "itzg"

    # Slug of the Image
    image = "minecraft-server"

    # Tag of the Image
    # see https://hub.docker.com/r/itzg/minecraft-server/tags?name=java21-alpine
    tag = "2023.11.0-java21-alpine"

    # Digest of the Tag of the Image
    digest = "sha256:9aa9149351649c7801f952f1cb3ea9b91529f8366cd6da135a9b54fbbbbdfde2"
  }
}

variable "nomad_task_name" {
  type        = string
  description = "Name for the Task."
  default     = "minecraft"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/resources
variable "nomad_task_resources" {
  type = object({
    cpu        = number
    cores      = number
    memory     = number
    memory_max = number
  })

  description = "Resource Limits for the Task."

  default = {
    # Tasks can ask for `cpu` or `cores`, not both.
    # value in MHz
    cpu = 4000

    # Tasks can ask for `cpu` or `cores`, not both.
    # see https://developer.hashicorp.com/nomad/docs/job-specification/resources#cores
    # and https://developer.hashicorp.com/nomad/docs/drivers/docker#cpu
    cores = null

    # value in MB
    # 2048 = ~10 players, 4096 = ~25 players
    # 6144 = ~40 players, 8192 = ~90 players
    # 10240 = ~150+ players
    # see https://apexminecrafthosting.com/how-much-ram-do-i-need-for-my-server/
    memory = 4096

    # value in MB
    # see https://developer.hashicorp.com/nomad/docs/job-specification/resources#memory-oversubscription
    # and https://developer.hashicorp.com/nomad/docs/drivers/docker#memory
    memory_max = 5120
  }
}
