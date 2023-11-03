#######################################
## Application-specific Configuration #
#######################################

# This Pack does not have any application-specific configuration.

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
  default = "flagd"
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
  default     = 10
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
    migrate = false

    # size of the ephemeral disk in MB
    size = 128

    sticky = false
  }
}

variable "nomad_group_name" {
  type        = string
  description = "Name for the Group."
  default     = "flagd"
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
    name           = string
    omit_check     = bool
    path           = string
    port           = number
    type           = string
  }))

  description = "Port Configuration for the Group."

  default = {
    # port for flagd
    main = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = "POST"
      name           = "main"
      omit_check     = true
      path           = "/"
      port           = 8013
      type           = "http"
    },

    # port for flagd healthcheck
    # see https://flagd.dev/reference/monitoring/?h=health#http
    health = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = "GET"
      name           = "health"
      omit_check     = false
      path           = "/healthz"
      port           = 8014
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
  default     = "flagd"
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
    "flagd",
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

  default = {}
}

# see https://developer.hashicorp.com/nomad/docs/drivers/docker#args
variable "nomad_task_args" {
  type        = list(string)
  description = "Arguments to pass to the Task."

  # see https://flagd.dev/reference/flagd-cli/flagd_start/
  default = []
}

# see https://developer.hashicorp.com/nomad/docs/drivers/docker#args
variable "nomad_task_command" {
  type        = string
  description = "Command to pass to the Task."

  # see https://flagd.dev/quick-start/#start-flagd
  default = "start"
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

  # see https://github.com/open-feature/flagd/pkgs/container/flagd
  default = {
    # Container Registry URL where the Image is hosted
    registry = "ghcr.io"

    # Namespace of the Image
    namespace = "open-feature"

    # Slug of the Image
    image = "flagd"

    # Tag of the Image
    tag = "v0.6.7"

    # Digest of the Tag of the Image
    digest = "sha256:bc771a0e42089111784f06168238304212c9f22c9b472934de5d4bd742a09a81"
  }
}

variable "nomad_task_name" {
  type        = string
  description = "Name for the Task."
  default     = "flagd"
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
    memory = 64

    # value in MB
    # see https://developer.hashicorp.com/nomad/docs/job-specification/resources#memory-oversubscription
    # and https://developer.hashicorp.com/nomad/docs/drivers/docker#memory
    memory_max = 512
  }
}
