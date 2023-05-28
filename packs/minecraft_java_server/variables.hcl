variable "config" {
  type = object({
    allow_flight                 = bool
    allow_nether                 = bool
    announce_player_achievements = bool
    console                      = bool
    data                         = string
    difficulty                   = string
    disable_healthcheck          = bool
    enable_command_block         = bool
    enable_query                 = bool
    enable_rcon                  = bool
    enable_rolling_logs          = bool
    eula                         = bool
    generate_structures          = bool
    gui                          = bool
    hardcore                     = bool
    icon                         = string
    level_type                   = string
    max_build_height             = number
    max_players                  = number
    max_tick_time                = number
    max_world_size               = number
    memory                       = string
    mode                         = string
    mods_file                    = string
    motd                         = string
    online_mode                  = bool
    override_icon                = bool
    pvp                          = bool
    rcon_password                = string
    remove_old_mods              = bool
    seed                         = string
    server_name                  = string
    snooper_enabled              = bool
    spawn_animals                = bool
    spawn_monsters               = bool
    spawn_npcs                   = bool
    spawn_protection             = number
    tz                           = string
    use_aikar_flags              = bool
    version                      = string
    view_distance                = number
    world                        = string
  })

  description = "Application configuration."

  # this section contains a non-exhaustive selection of Minecraft Server configuration options
  # see https://github.com/itzg/docker-minecraft-server/blob/master/README.md#server-configuration for all available options.
  default = {
    # toggle to enable PC flight
    allow_flight = true

    # toggle to enable The Nether
    allow_nether = false

    # toggle to announce player achievements
    announce_player_achievements = false

    # toggle to enable in-game console
    console = true

    # Directory where Application data will be stored
    data = "/data"

    # in-game difficulty level
    difficulty = "peaceful"

    # toggle to disable container health check
    disable_healthcheck = false

    # toggle to enable Command Blocks
    # see https://minecraft.fandom.com/wiki/Command_Block
    enable_command_block = false

    # toggle to enable Gamespy Query protocol
    enable_query = false

    # toggle to enable RCON interface
    enable_rcon = true

    # toggle to enable log rolling
    enable_rolling_logs = true

    # toggle to accept end-user license agreement
    eula = true

    # toggle to pre-generate structures (e.g.: villages, outposts)
    generate_structures = true

    # toggle to enable GUI
    gui = true

    # toggle to enable Hardcore Mode
    # see https://minecraft.fandom.com/wiki/Hardcore
    hardcore = false

    # Server Icon
    icon = "https://mystickermania.com/cdn/stickers/minecraft/minecraft-bee-512x512.png"

    # Level Type (e.g.: Normal, Flat)
    # see https://minecraft.fandom.com/wiki/Server.properties#level-type
    level_type = "flat"

    # maximum allowed building height (in blocks)
    max_build_height = 256

    # maximum allowed player count
    max_players = 20

    # maximum number of msec a single tick may take before watchdog kicks in
    max_tick_time = 60000

    # maximum radius of world size (in blocks)
    max_world_size = 10000

    # initial memory to assign
    memory = "4G"

    # Game Mode to start with
    # see https://github.com/itzg/docker-minecraft-server/blob/master/README.md#game-mode
    mode = "creative"

    # Path to text file with Mod URLs
    mods_file = "/extras/mods.txt"

    # Message of the Day
    # see https://minecraft.fandom.com/wiki/Formatting_codes
    motd = "§2Minecraft§r Java Server"

    # toggle to enable Account Authentication (with Minecraft.net / Microsoft Account)
    online_mode = false

    # toggle to enable overriding default server icon
    override_icon = true

    # toggle to enable player-versus-player damage
    pvp = false

    # RCON Interface password
    rcon_password = "AW96B6"

    # toggle to enable removal of old mods
    remove_old_mods = true

    # in-game level seed
    seed = ""

    # in-game name of server
    server_name = "Minecraft Java Server"

    # toggle to enable sending updates to `snoop.minecraft.net`
    snooper_enabled = false

    # toggle to enable animals to spawn
    spawn_animals = true

    # toggle to enable monsters to spawn
    spawn_monsters = false

    # toggle to enable non-player characters to spawn
    spawn_npcs = true

    # sets area that non-ops cannot alter (in blocks)
    spawn_protection = 0

    # timezone
    tz = "Europe/Amsterdam"

    # toggle to enable optimized JVM flags for GC tuning
    # see https://github.com/itzg/docker-minecraft-server#enable-aikars-flags
    use_aikar_flags = true

    # Minecraft version to run
    version = "1.19.4"

    # set the amount of World Data to send to clients to define viewing distance (in blocks)
    view_distance = 20

    # URL to Minecraft World ZIP archive
    world = ""
  }
}

variable "config_mounts" {
  type = map(object({
    name        = string
    type        = string
    destination = string
    read_only   = bool
  }))

  description = "Mounts Configuration for the Application."

  default = {
    data = {
      name        = "minecraft_data",
      type        = "host"
      destination = "/data"
      read_only   = false
    },

    extras = {
      name        = "minecraft_extras",
      type        = "host"
      destination = "/extras"
      read_only   = false
    },

    worlddata = {
      name        = "minecraft_worlddata",
      type        = "host"
      destination = "/worlds"
      read_only   = false
    },
  }
}

variable "config_ports" {
  type = map(object({
    name = string,
    path = string,
    port = number,
    type = string,
  }))

  description = "Port Configuration for the Application."

  default = {
    # port for Minecraft server
    main = {
      name = "minecraft_java_server_main",
      path = null
      port = 25565,
      type = "tcp",
    },

    # port for RCON Interface
    rcon = {
      name = "minecraft_java_server_rcon",
      path = null,
      port = 25575,
      type = "tcp",
    },
  }
}

variable "consul_service_name" {
  type        = string
  description = "Consul Service Name for the Application."
  default     = "minecraft_java_server"
}

variable "consul_service_tags" {
  type        = list(string)
  description = "Consul Service Tags for the Application."
  default     = []
}

variable "count" {
  type        = number
  description = "Number of desired Job Deployments."
  default     = 1
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#datacenters
variable "datacenters" {
  type        = list(string)
  description = "Datacenters that are eligible for Task Placement."

  default = [
    "*"
  ]

  # TODO: enable when `nomad-pack` supports `validation` stanzas
  #  # see https://developer.hashicorp.com/nomad/docs/job-specification/hcl2/variables#input-variable-custom-validation-rules
  #  validation {
  #    condition     = length(var.datacenters) > 1
  #    error_message = "The `datacenters` list must contain at least 1 item."
  #  }
}

variable "driver" {
  type        = string
  description = "Driver to use for the Job."
  default     = "docker"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
variable "ephemeral_disk" {
  type = object({
    migrate = bool
    size    = number
    sticky  = bool
  })

  description = "Ephemeral Disk configuration for the Application."

  default = {
    # make best-effort attempt to migrate data to a different node if no placement is possible on the original node.
    migrate = true

    # size of the ephemeral disk in MB
    size = 512

    # make best-effort attempt to place an updated allocation on the same node.
    sticky = true
  }
}

variable "image" {
  type = object({
    registry  = string
    namespace = string
    image     = string
    tag       = string
    digest    = string
  })

  description = "Content Address to use for the Container Image."

  # see https://hub.docker.com/r/itzg/minecraft-server/tags
  default = {
    # Container Registry URL where the Image is hosted
    registry = "hub.docker.com"

    # Namespace of the Image
    namespace = "itzg"

    # Slug of the Image
    image = "minecraft-server"

    # Tag of the Image
    tag = "java17"

    # Digest of the Tag of the Image
    digest = "sha256:c6c6afd0e3fa4f06074a449c2dc8248a55a7c639bdda5754d5eaa6963447c909"
  }
}

variable "job_name" {
  type        = string
  description = "Name of the Job."
  default     = "minecraft_java_server"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#namespace
variable "namespace" {
  type        = string
  description = "Namespace in which the Job should be placed."
  default     = "default"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#priority
variable "priority" {
  type        = number
  description = "Priority of the Job."
  default     = 50
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#regions
variable "region" {
  type        = string
  description = "Regions that are eligible for Job Deployment."
  default     = "global"
}

# see https://github.com/hashicorp/nomad-pack/blob/main/internal/creator/templates/pack_readme.md#consul-service-and-load-balancer-integration
variable "register_consul_service" {
  type        = bool
  description = "Toggle to enable Consul Service Registration for the Job."
  default     = false
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/resources
variable "resources" {
  type = object({
    cpu    = number
    memory = number
  })

  description = "Resources to assign to the Application."

  default = {
    # value in MHz
    cpu = 1000

    # value in MB
    # 2048 = ~10 players, 4096 = ~25 players
    # 6144 = ~40 players, 8192 = ~90 players
    # 10240 = ~150+ players
    # see https://apexminecrafthosting.com/how-much-ram-do-i-need-for-my-server/
    memory = 4096
  }
}

variable "verbose_output" {
  type        = bool
  description = "Toggle to enable verbose output."
  default     = true
}