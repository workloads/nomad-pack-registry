variable "nomad_task_image" {
  type = object({
    registry  = string
    namespace = string
    image     = string
    tag       = string
    digest    = map(string)
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
    tag = "v0.8.1"

    # Digest of the Tag of the Image
    digest = {
      # Darwin uses the same image as Linux
      "linux/amd64" = "sha256:eea3b8c9f517e3e967854939a39f86b4231bde2b60b190d8aedef8da8c47cb96"
      "linux/arm64" = "sha256:a42641d479372b4e3a236a4105f5efaa8e470521f5693ec9b928b2bca2ef4633"
    }
  }
}


#######################################
## Application-specific Configuration #
#######################################

# n/a

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
  default = "hello_world"
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

variable "nomad_group_count" {
  type        = number
  description = "Count of Deployments for the Group."
  default     = 1
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#regions
variable "nomad_job_region" {
  type        = string
  description = "Region for the Job."
  default     = "global"
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
    size = 128

    # make best-effort attempt to place an updated allocation on the same node.
    sticky = false
  }
}

variable "nomad_group_name" {
  type        = string
  description = "Name for the Group."
  default     = "hello_world"
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
  default     = "hello_world"
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
    "hello_world",
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

variable "nomad_task_driver" {
  type        = string
  description = "Driver to use for the Task."
  default     = "raw_exec"
}

variable "nomad_task_name" {
  type        = string
  description = "Name for the Task."
  default     = "hello_world"
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
    memory_max = 1024
  }
}
