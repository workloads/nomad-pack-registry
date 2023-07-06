variable "app_rwa_admin" {
  type        = bool
  description = "Toggle to set Initial User as Admin."
  default     = true
}

variable "app_rwa_env" {
  type        = bool
  description = "Toggle to allow configuration through Environment Variables."
  default     = true
}

variable "app_rwa_game" {
  type        = string
  description = "Initial Game-Type."
  default     = "minecraft"
}

variable "app_rwa_password" {
  type        = string
  description = "Initial User Password."
  default     = "AW96B6"
}

variable "app_rwa_rcon_host" {
  type        = string
  description = "RCON Target Server Host."
  default     = "172.17.0.2"
}

variable "app_rwa_rcon_port" {
  type        = number
  description = "RCON Target Server Port."
  default     = 25575
}

variable "app_rwa_rcon_password" {
  type        = string
  description = "RCON Target Server Password."
  default     = "AW96B6"
}

variable "app_rwa_read_only_widget_options" {
  type        = bool
  description = "Toggle to prevent Initial User from changing Widget Options."
  default     = false
}

variable "app_rwa_restrict_commands" {
  type        = string
  description = "Restricted Commands for Initial User."
  default     = "ban,deop,stop"
}

variable "app_rwa_restrict_widgets" {
  type        = string
  description = "Hidden Widgets for Initial User."
  default     = ""
}

variable "app_rwa_server_name" {
  type        = string
  description = "Name of Target Server."
  default     = "minecraft"
}

variable "app_rwa_username" {
  type        = string
  description = "Initial User Username."
  default     = "admin"
}

variable "app_rwa_web_rcon" {
  type        = bool
  description = "Toggle to enable Web RCON on Target Server."
  default     = false
}

variable "nomad_group_count" {
  type        = number
  description = "Count of Deployments for the Job."
  default     = 1
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#datacenters
variable "nomad_job_datacenters" {
  type        = list(string)
  description = "Eligible Datacenters for the Task."

  default = [
    "*"
  ]
}

variable "nomad_task_driver" {
  type        = string
  description = "Driver to use for the Job."
  default     = "docker"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
variable "nomad_group_ephemeral_disk" {
  type = object({
    migrate = bool
    size    = number
    sticky  = bool
  })

  description = "Ephemeral Disk Configuration for the Application."

  default = {
    # make best-effort attempt to migrate data to a different node if no placement is possible on the original node.
    migrate = true

    # size of the ephemeral disk in MB
    size = 128

    # make best-effort attempt to place an updated allocation on the same node.
    sticky = false
  }
}

variable "nomad_group_name" {
  type        = string
  description = "Name for the Group."
  default     = "rcon"
}

variable "nomad_task_image" {
  type = object({
    registry  = string
    namespace = string
    image     = string
    tag       = string
    digest    = string
  })

  description = "Content Address to use for the Container Image."

  # see https://hub.docker.com/r/itzg/rcon/tags
  default = {
    # Container Registry URL where the Image is hosted
    registry = "index.docker.io"

    # Namespace of the Image
    namespace = "itzg"

    # Slug of the Image
    image = "rcon"

    # Tag of the Image
    tag = "latest"

    # Digest of the Tag of the Image
    digest = "sha256:a9fc0b4116a7034c4849a4160d139a589bbf9211df64b48cc404e74c3e7bb730"
  }
}

variable "nomad_job_name" {
  type        = string
  description = "Name for the Job."

  # value will be truncated to 63 characters when necessary
  default = "rcon_web"
}

variable "nomad_group_tags" {
  type        = list(string)
  description = "List of Tags for the Job."

  default = [
    "rcon",
  ]
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#namespace
variable "nomad_job_namespace" {
  type        = string
  description = "Namespace for the Job."
  default     = "default"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
variable "nomad_group_network_mode" {
  type        = string
  description = "Network Mode for the Job."
  default     = "host"
}

variable "nomad_group_ports" {
  type = map(object({
    name           = string
    path           = string
    port           = number
    type           = string
    host_network   = string
    check_interval = string
    check_timeout  = string
  }))

  description = "Port Configuration for the Application."

  default = {
    # port for web UI
    main = {
      name           = "rcon_web_main"
      path           = "/"
      port           = 4326
      type           = "http"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for WebSocket Interface
    websocket = {
      name           = "rcon_web_websocket"
      path           = null
      port           = 4327
      type           = "tcp"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },
  }
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#priority
variable "nomad_job_priority" {
  type        = number
  description = "Priority for the Job."
  default     = 50
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#regions
variable "nomad_job_region" {
  type        = string
  description = "Region for the Job."
  default     = "global"
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
    cpu = 500

    # Tasks can ask for `cpu` or `cores`, not both.
    # see https://developer.hashicorp.com/nomad/docs/job-specification/resources#cores
    # and https://developer.hashicorp.com/nomad/docs/drivers/docker#cpu
    cores = null

    # value in MB
    memory = 512

    # value in MB
    # see https://developer.hashicorp.com/nomad/docs/job-specification/resources#memory-oversubscription
    # and https://developer.hashicorp.com/nomad/docs/drivers/docker#memory
    memory_max = 1024
  }
}

variable "nomad_group_service_name_prefix" {
  type        = string
  description = "Name for the Group Service."
  default     = "rcon_web"
}

variable "nomad_group_service_provider" {
  type        = string
  description = "Provider for the Group Service."
  default     = "nomad"
}

variable "nomad_group_restart_logic" {
  type = object({
    attempts = number
    interval = string
    delay    = string
    mode     = string
  })

  description = "Restart Logic for the Application."

  default = {
    attempts = 3
    interval = "120s"
    delay    = "30s"
    mode     = "fail"
  }
}

variable "nomad_task_name" {
  type        = string
  description = "Name for the Task."
  default     = "rcon_web"
}

variable "verbose_output" {
  type        = bool
  description = "Toggle to enable verbose output."
  default     = true
}

variable "nomad_group_volumes" {
  type = map(object({
    name        = string
    type        = string
    destination = string
    read_only   = bool
  }))

  description = "Volumes for the Group."

  default = {}
}
