#######################################
## Application-specific Configuration #
#######################################

variable "grafana_agent_configuration" {
  type = string
  description = "Local path to the configuration file for the Grafana Agent."
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
  default = "grafana_agent"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#namespace
variable "nomad_job_namespace" {
  type        = string
  description = "Namespace for the Job."
  default     = "default"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#type
variable "nomad_job_type" {
  type        = string
  description = "Type for the Job - service or system. Service to run one instance of Grafana Agent (for a centralised collector), system to run one on each client node (to observe each node and its workloads)."
  default     = "service"
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

variable "nomad_group_name" {
  type        = string
  description = "Name for the Group."
  default     = "grafana_agent"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
variable "nomad_group_network_mode" {
  type        = string
  description = "Network Mode for the Group."
  default     = "bridge"
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
    tags           = list(string)
  }))

  description = "Port Configuration for the Group."

  default = {
    ready = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = "GET"
      omit_check     = true
      path           = "/-/ready"
      port           = 12345
      type           = "http"
      tags           = []
    } /*,

    health = {
      check_interval = "30s"
      check_timeout  = "15s"
      host_network   = null
      method         = "GET"
      name           = "health"
      omit_check     = false
      path           = "/-/healthy"
      port           = 12345
      type           = "http"
    },
    */
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
  default     = "grafana_agent"
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
    "grafana_agent",
  ]
}

# see https://developer.hashicorp.com/nomad/docs/drivers/docker#args
variable "nomad_task_args" {
  type        = list(string)
  description = "Arguments to pass to the Task."

  default = [ "run", "--server.http.listen-addr=0.0.0.0:12345", "$${NOMAD_TASK_DIR}/grafana-cloud-agent.river"]
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
    registry = "docker.io"

    # Namespace of the Image
    namespace = "grafana"

    # Slug of the Image
    image = "agent"

    # Tag of the Image
    tag = "v0.38.1"

    # Digest of the Tag of the Image
    digest = "sha256:fb248f9c5de9354e39d63fc3a5a8bde508cead41ecc3492f0e9d6a3d315d50b3"
  }
}

variable "nomad_task_name" {
  type        = string
  description = "Name for the Task."
  default     = "grafana_agent"
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
    memory = 128

    # value in MB
    # see https://developer.hashicorp.com/nomad/docs/job-specification/resources#memory-oversubscription
    # and https://developer.hashicorp.com/nomad/docs/drivers/docker#memory
    memory_max = 512
  }
}
