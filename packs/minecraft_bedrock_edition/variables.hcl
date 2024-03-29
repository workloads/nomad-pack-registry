#######################################
## Application-specific Configuration #
#######################################

# this section contains a non-exhaustive selection of Minecraft Server configuration options
# see https://minecraft.wiki/w/Server.properties#Bedrock_Edition_3 for all available options.

variable "app_allow_cheats" {
  type        = bool
  description = "Toggle to enable Commands and Cheats."
  default     = true
}

variable "app_allow_list" {
  type        = bool
  description = "Toggle to enable Allow-List (as stored in `allowlist.json`)."
  default     = false
}

variable "app_compression_threshold" {
  type        = number
  description = "Size of raw Network Payload to compress."
  default     = 1
}

variable "app_content_log_file_enabled" {
  type        = bool
  description = "Toggle to disable file-based Logging."
  default     = false
}

variable "app_correct_player_movement" {
  type        = bool
  description = "Toggle to enable server-side Movement Validation."
  default     = false
}

variable "app_default_player_permission_level" {
  type        = string
  description = "Default Permission for new Players."
  default     = "member"
}

variable "app_difficulty" {
  type        = string
  description = "Difficulty Level."
  default     = "peaceful"
}

variable "app_eula" {
  type        = bool
  description = "Toggle to accept End User License Agreement."
  default     = true
}

variable "app_force_gamemode" {
  type        = bool
  description = "Toggle to force Players to always join in the default Game Mode."
  default     = false
}

variable "app_gamemode" {
  type        = string
  description = "Game Mode."
  default     = "creative"
}

variable "app_level_name" {
  type        = string
  description = "Name of Level to load."

  # World Data must be available in the `worlds` directory
  default = ""
}

variable "app_level_seed" {
  type        = string
  description = "Level Seed"

  # see https://www.reddit.com/r/minecraftseeds/ for inspiration
  default = "-3420545464665791887"
}

variable "app_level_type" {
  type        = string
  description = "Level Type."

  # options: `DEFAULT`, `FLAT`, `NORMAL`
  default = "DEFAULT"
}

variable "app_max_players" {
  type        = number
  description = "Maximum allowed Player Count."
  default     = 10
}

variable "app_max_threads" {
  type        = number
  description = "Maximum amount of Threads to use."
  default     = 0
}

variable "app_online_mode" {
  type        = bool
  description = "Toggle to enable Account Authentication (with Minecraft.net / Microsoft Account)."
  default     = false
}

# see https://minecraft.wiki/w/Permission_level
variable "app_op_permission_level" {
  type        = number
  description = "Sets the default Permission Level for new Ops."

  # 1 = moderator, 2 = gamemaster, 3 = administrator, 4 = owner
 default = 2
}

variable "app_player_idle_timeout" {
  type        = number
  description = "Idle Timeout (in minutes) after which a Player is kicked."
  default     = 15
}

variable "app_player_movement_distance_threshold" {
  type        = number
  description = "Minimum Distance (in blocks) a Player must move before their Movement is validated."
  default     = 0.3
}

variable "app_player_movement_duration_threshold_in_ms" {
  type        = number
  description = "Minimum Duration (in msec) a Player must move before their Movement is validated."
  default     = 500
}

variable "app_player_movement_score_threshold" {
  type        = number
  description = "Number of incongruent Movements before a Player is kicked."
  default     = 20
}

variable "app_server_authoritative_block_breaking" {
  type        = bool
  description = "Toggle to enable Server-Side Block Breaking Validation."
  default     = false
}

variable "app_server_authoritative_movement" {
  type        = string
  description = "Toggle to enable Server-Authoritative Movement Validation."
  default     = "server-auth"
}

variable "app_server_name" {
  type        = string
  description = "Name of the Server."
  default     = "Minecraft Bedrock Edition Server"
}

variable "app_texturepack_required" {
  type        = bool
  description = "Toggle to enable Texture Pack Requirement"
  default     = false
}

variable "app_tick_distance" {
  type        = number
  description = "Maximum allowed Tick Distance (in chunks)."
  default     = 4
}

# see https://www.minecraft.net/en-us/download/server/bedrock
variable "app_version" {
  type        = string
  description = "Minecraft Version."
  default     = "1.20.1.02"
}

variable "app_view_distance" {
  type        = number
  description = "Maximum allowed View Distance (in chunks)."
  default     = 32
}

###############################
## Pack-specific Configuration #
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

  description = "Port and Healthcheck Configuration for the Group."

  default = {
    # port for Minecraft server
    main = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = null
      omit_check     = false
      path           = null
      port           = 19132
      type           = "tcp"
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
    "minecraft-bedrock-edition"
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
    data = {
      name        = "minecraft_bedrock_data",
      type        = "host"
      destination = "/data"
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

  # see https://hub.docker.com/r/itzg/minecraft-bedrock-server/tags
  default = {
    # Container Registry URL where the Image is hosted
    registry = "index.docker.io"

    # Namespace of the Image
    namespace = "itzg"

    # Slug of the Image
    image = "minecraft-bedrock-server"

    # Tag of the Image
    tag = "2023.8.1"

    # Digest of the Tag of the Image
    digest = "sha256:e2019e959daa70dffd1468aaa1348bc906170709bf2c790bee302fc1efedbde7"
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
