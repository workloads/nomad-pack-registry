variable "app_boundary_helper_path" {
  type        = string
  description = "Path to the Boundary Helper Binary."
  default     = "/Users/ksatirli/Desktop/workloads/boundary-helper/dist/boundary-helper"
}

variable "app_boundary_helper_output_file_mode" {
  type        = string
  description = "File Mode of the Output File created by the Boundary Helper Binary."
  default     = "0644"
}

variable "app_enable_hcp_boundary_support" {
  type        = bool
  description = "Toggle to enable HCP Boundary Support (and forego self-hosted Boundary Enterprise Cluster registration workflows."
  default     = true
}

# full worker name format is `<prefix>-<NOMAD_ALLOC_NAME>-<NOMAD_SHORT_ALLOC_ID>`
# value will be transformed to lowercase
variable "app_worker_name_prefix" {
  type        = string
  description = "Prefix for the Boundary Worker Name."

  # a trailing separation character (`-`) will be added automatically to allow
  # for easier identification of Nomad-orchestrated Workers in the Boundary UI
  default = "nomad"
}

variable "app_worker_description" {
  type        = string
  description = "Description for the Boundary Worker."
  default     = "Nomad-managed Boundary Worker."
}

# only relevant in a non-HCP Boundary setting
variable "app_initial_upstreams" {
  type        = list(string)
  description = "Initial Upstreams for the Boundary Worker."
  default     = []
}

variable "app_worker_tags" {
  type        = list(string)
  description = "Tags for the Boundary Worker."

  default = [
    "nomad-managed-worker",
    "nomad-agent",
  ]
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
  default = "boundary_worker"
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
    sticky = true
  }
}

variable "nomad_group_name" {
  type        = string
  description = "Name for the Group."
  default     = "boundary_worker"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
variable "nomad_group_network_mode" {
  type        = string
  description = "Network Mode for the Group."
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

  description = "Port Configuration for the Group."

  default = {
    # port for Worker
    # see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp
    proxy = {
      name           = "boundary_worker_proxy"
      path           = null
      port           = 9202
      protocol       = "tcp"
      type           = "tcp"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    #    # port for Ops
    #    # see https://developer.hashicorp.com/boundary/docs/configuration/listener#ops
    #    ops = {
    #      name           = "boundary_worker_ops"
    #      path           = "/health"
    #      port           = 9203
    #      protocol       = "http"
    #      type           = "http"
    #      host_network   = null
    #      check_interval = "30s"
    #      check_timeout  = "15s"
    #    },
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
  default     = "boundary_worker"
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
    "boundary",
    "boundary-workers",
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

  default = { }
}

variable "nomad_task_driver" {
  type        = string
  description = "Driver to use for the Task."
  default     = "raw_exec"
}

variable "nomad_task_name" {
  type        = string
  description = "Name for the Task."
  default     = "boundary_worker"
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
