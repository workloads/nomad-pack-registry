#######################
# Basic Configuration #
#######################

variable "app_dd_site" {
  type        = string
  description = "Intake Server to use."
  default     = "datadoghq.com"
}

variable "app_dd_url" {
  type        = string
  description = "Hostname of the Intake Server to use."
  default     = "https://app.datadoghq.com"
}

variable "app_dd_skip_ssl_validation" {
  type        = bool
  description = "Toggle to skip validation of TLS Certificates."
  default     = false
}

variable "app_dd_env" {
  type        = string
  description = "Environment Name where the agent is running."
  default     = "testing"
}

variable "app_dd_min_tls_version" {
  type        = string
  description = "Minimum TLS version for Intake Server."
  default     = "tlsv1.2"
}

# default to Nomad-provided Hostname
variable "app_dd_hostname" {
  type        = string
  description = "Force-set the Hostname."
  default     = "$${attr.unique.hostname}"
}

# see https://docs.datadoghq.com/agent/faq/how-datadog-agent-determines-the-hostname/
variable "app_dd_hostname_fqdn" {
  type        = bool
  description = "Toggle to use a FQDN instead of a short hostname."
  default     = false
}

# valid values are `low`, `orchestrator`, `high`
variable "app_dd_checks_tag_cardinality" {
  type        = string
  description = "Configure the level of granularity of Tags to send for checks Metrics and Events."
  default     = "low"
}

# valid values are `low`, `orchestrator`, `high`
variable "app_dd_dogstatsd_tag_cardinality" {
  type        = string
  description = "Configure the level of granularity of Tags to send for DogStatsD Metrics and Events."
  default     = "low"
}

variable "app_dd_histogram_aggregates" {
  type        = list(string)
  description = "Configure which aggregated value to compute."

  default = [
    "max",
    "median",
    "avg",
    "count"
  ]
}

variable "app_dd_histogram_percentiles" {
  type        = list(string)
  description = "Configure which Percentiles are computed by the Agent."

  default = [
    "0.95"
  ]
}

variable "app_dd_histogram_copy_to_distribution" {
  type        = bool
  description = "Toggle to copy Histogram values to Distribution Metrics for global distributions."
  default     = false
}

variable "app_dd_histogram_copy_to_distribution_prefix" {
  type        = string
  description = "Prefix to add to Distribution Metrics."
  default     = ""
}

variable "app_dd_aggregator_stop_timeout" {
  type        = number
  description = "Timeout (in seconds) for the Aggregator to flush data before stopping."
  default     = 5
}

variable "app_dd_aggregator_buffer_size" {
  type        = number
  description = "Default Buffer Size for the Aggregator."
  default     = 100
}

# valid values are `aws`, `gcp`, `azure`, `alibaba`, `tencent`, `oracle`, `ibm`
variable "app_dd_cloud_provider_metadata" {
  type        = list(string)
  description = "List of CSPs to query metadata endpoints for"

  default = [
    "aws",
    "gcp",
    "azure"
  ]
}

# see https://docs.datadoghq.com/integrations/faq/how-do-i-pull-my-ec2-tags-without-using-the-aws-integration/
variable "app_dd_collect_ec2_tags" {
  type        = bool
  description = "Toggle to collect AWS EC2 metadata as Host Tags."
  default     = false
}

variable "app_dd_exclude_ec2_tags" {
  type        = list(string)
  description = "AWS EC2 tags to exclude from being collected as Host Tags."
  default     = []
}

variable "app_dd_collect_ec2_tags_use_imds" {
  type        = bool
  description = "Toggle to use IMDS (instead of EC2 API) to collect AWS EC2 metadata."
  default     = false
}

variable "app_dd_ec2_metadata_timeout" {
  type        = number
  description = "Timeout (in milliseconds) on calls to the AWS EC2 metadata endpoints."
  default     = 1000
}

# see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html#instance-metadata-transition-to-version-2
variable "app_dd_ec2_prefer_imdsv2" {
  type        = bool
  description = "Toggle to use IMDSv2 to collect AWS EC2 metadata."
  default     = false
}

variable "app_dd_collect_gce_tags" {
  type        = bool
  description = "Toggle to collect GCP GCE metadata as Host Tags."
  default     = true
}

variable "app_dd_exclude_gce_tags" {
  type        = list(string)
  description = "GCP GCE tags to exclude from being collected as Host Tags."

  default = [
    "containerd-configure-sh",
    "startup-script",
    "shutdown-script",
    "configure-sh",
    "sshKeys",
    "ssh-keys",
    "user-data",
    "cli-cert",
    "ipsec-cert",
    "ssl-cert",
    "google-container-manifest",
  ]
}

variable "app_dd_gce_send_project_id_tag" {
  type        = bool
  description = "Toggle to send GCP Project Name and ID as Host Tag."
  default     = false
}

variable "app_dd_gce_metadata_timeout" {
  type        = number
  description = "Timeout (in milliseconds) on calls to the GCP GCE metadata endpoints."
  default     = 1000
}

# valid values are `os`, `name`, `name_and_resource_group`, `full`, `vmid`
variable "app_dd_azure_hostname_style" {
  type    = string
  default = "os"
}

# see https://docs.datadoghq.com/agent/troubleshooting/send_a_flare/
variable "app_dd_flare_stripped_keys" {
  type        = list(string)
  description = "Additional sensitive keys that should be scrubbed before sending an Agent Flare."
  default     = []
}

# see https://godoc.org/golang.org/x/net/http/httpproxy#Config
variable "app_dd_no_proxy_nonexact_match" {
  type        = bool
  description = "Toggle to enable more flexible `no_proxy` matching."
  default     = false
}

variable "app_dd_use_proxy_for_cloud_metadata" {
  type        = bool
  description = "Toggle to remove CSP IPs from the transport's `no_proxy` list."
}

# see https://docs.datadoghq.com/infrastructure/list/#agent-configuration
variable "app_dd_inventories_configuration_enabled" {
  type        = bool
  description = "Toggle to enable Agent to send its own configuration."
  default     = false
}

variable "app_dd_auto_exit_noprocess_enabled" {
  type        = bool
  description = "Toggle to enable the `noprocess` method."
  default     = false
}

variable "app_dd_auto_exit_noprocess_excluded_processes" {
  type        = list(string)
  description = "List of Regular Expressions to exclude extra processes with."
  default     = []
}

variable "app_dd_auto_exit_validation_period" {
  type        = number
  description = "Delay (in seconds) for \"auto exit\" validation before exiting."
  default     = 60
}

variable "app_dd_observability_pipelines_worker_metrics_enabled" {
  type        = bool
  description = "Toggle to enable forwarding of Metrics to an Observability Pipelines Worker."
  default     = false
}

variable "app_dd_observability_pipelines_worker_metrics_url" {
  type        = string
  description = "URL endpoint for the Observability Pipelines Worker to send Metrics to."
  default     = ""
}

variable "app_dd_observability_pipelines_worker_logs_enabled" {
  type        = bool
  description = "Toggle to enable forwarding of Logs to an Observability Pipelines Worker."
  default     = false
}

variable "app_dd_observability_pipelines_worker_logs_url" {
  type        = string
  description = "URL endpoint for the Observability Pipelines Worker to send Logs to."
  default     = ""
}

variable "app_dd_observability_pipelines_worker_traces_enabled" {
  type        = bool
  description = "Toggle to enable forwarding of Traces to an Observability Pipelines Worker."
  default     = false
}

variable "app_dd_observability_pipelines_worker_traces_url" {
  type        = string
  description = "URL endpoint for the Observability Pipelines Worker to send Traces to."
  default     = ""
}

##########################
# Advanced Configuration #
##########################

variable "app_dd_confd_path" {
  type        = string
  description = "Path to the directory containing `checks.d` configuration files."
  default     = ""
}

variable "app_dd_additional_checksd" {
  type        = string
  description = "Path to the directory containing additional Python checks."
  default     = ""
}

# This is a sensitive value. Datadog does not recommend changing it unless you have a specific use case.
variable "app_dd_check_runners" {
  type        = number
  description = "Number of concurrent Check Runners available for execution."
  default     = 4
}

variable "app_dd_enable_metadata_collection" {
  type        = bool
  description = "Toggle to enable the collection of system metadata from the Agent."
  default     = true
}

variable "app_dd_enable_gohai" {
  type        = bool
  description = "Toggle to enable `gohai` collection of system data from the Agent."
  default     = true
}

variable "app_dd_server_timeout" {
  type        = number
  description = "Timeout (in seconds) for the IPC API Server."
  default     = 30
}

variable "app_dd_procfs_path" {
  type        = string
  description = "Path to the `procfs` file system."
  default     = ""
}

variable "app_dd_disable_py3_validation" {
  type        = bool
  description = "Toggle to disable Python 3 validation of Python checks."
  default     = false
}

variable "app_dd_python3_linter_timeout" {
  type        = number
  description = "Timeout (in seconds) for Python 3 Compatibility validation when running Python 2 of Python checks."
  default     = 120
}

variable "app_dd_memtrack_enabled" {
  type        = bool
  description = "Toggle to enable tracking of memory allocations made from the Python runtime loader."
  default     = true
}

variable "app_dd_tracemalloc_debug" {
  type        = bool
  description = "Toggle to enable debugging with `tracemalloc` for Python checks."
  default     = false
}

variable "app_dd_tracemalloc_include" {
  type        = list(string)
  description = "List of Python checks to enable `tracemalloc` for, when `tracemalloc_debug` is true."
  default     = []
}

variable "app_dd_tracemalloc_exclude" {
  type        = list(string)
  description = "List of Python checks to disable `tracemalloc` for, when `tracemalloc_debug` is true."
  default     = []
}

variable "app_dd_windows_use_pythonpath" {
  type        = bool
  description = "Toggle to honour the value of the `PYTHONPATH` environment variable. Windows only."
  default     = false
}

variable "app_dd_secret_backend_command" {
  type        = string
  description = "Path to a Command to execute to fetch Secrets."
  default     = ""
}

variable "app_dd_secret_backend_arguments" {
  type        = list(string)
  description = "List of arguments to give to the Secret Backend Command at each run."
  default     = []
}

variable "app_dd_secret_backend_output_max_size" {
  type        = number
  description = "Size (in bytes) of the buffer used to store the Secrets Backend Command's response. Applies to `stdout` and `stderr`."
  default     = 1048576
}

variable "app_dd_secret_backend_timeout" {
  type        = number
  description = "Timeout (in seconds) for the Secret Backend Command."
  default     = 30
}

variable "app_dd_secret_backend_skip_checks" {
  type        = bool
  description = "Toggle to disable fetching Secrets for Check Configurations."
  default     = false
}

variable "app_dd_secret_backend_remove_trailing_line_break" {
  type        = bool
  description = "Toggle to remove trailing line breaks from Secrets returned by the Secret Backend Command."
  default     = false
}

################################################
## Log Collection Configuration               ##
## see https://docs.datadoghq.com/agent/logs/ ##
################################################

variable "app_dd_logs_enabled" {
  type        = bool
  description = "Toggle to enable Log collection for the Agent."
  default     = false
}

variable "app_dd_logs_config_container_collect_all" {
  type        = bool
  description = "Toggle to enable Log Collection for all Containers."
  default     = false
}

variable "app_dd_logs_config_dd_url" {
  type        = string
  description = "Hostname of the Logs Server to use."
  default     = ""
}

variable "app_dd_logs_config_logs_no_ssl" {
  type        = bool
  description = "Toggle to disable TSL encryption for Log collection."
  default     = false
}

# see https://docs.datadoghq.com/agent/logs/advanced_log_collection/#global-processing-rules
variable "app_dd_logs_config_processing_rules" {
  type        = list(string)
  description = "List of Processing Rules to apply to all Logs"
  default     = []
}

variable "app_dd_logs_config_force_use_http" {
  type        = bool
  description = "Toggle to force the Agent to send Logs over insecure HTTP."
  default     = false
}

# value is ignored if `DD_LOGS_CONFIG_FORCE_USE_HTTP` is set to `true`
variable "app_dd_logs_force_use_tcp" {
  type        = bool
  description = "Toggle to force the Agent to send Logs over TCP."
  default     = false
}

variable "app_dd_logs_config_use_compression" {
  type        = bool
  description = "Toggle to enable Compression for Log collection."
  default     = false
}

# valid values are `0` (no compression) to `9` being maximum compression.
variable "app_dd_logs_config_compression_level" {
  type        = number
  description = "Compression Level for Log collection."
  default     = 6
}

variable "app_dd_logs_config_batch_wait" {
  type        = number
  description = "Maximum time (in seconds) the Agent waits to fill each batch of Logs before sending."
  default     = 5
}

# valid values are OS-specifc. Defaults for Windows and macOS are `200`, all other OS default to `500`.
variable "app_dd_logs_config_open_files_limit" {
  type        = number
  description = "Maximum number of files that can be tailed in parallel."
  default     = 500
}

# valid values are `by_name` and `by_modification_time`.
variable "app_dd_logs_config_file_wildcard_selection_mode" {
  type        = string
  description = "Strategy to use to prioritize wildcard matches if they exceed the open file limit."
  default     = "by_name"
}

#############################################
# Trace Collection Configuration            #
# see https://docs.datadoghq.com/agent/apm/ #
#############################################

variable "app_dd_apm_enabled" {
  type        = bool
  description = "Toggle to enable the APM Agent."
  default     = true
}

variable "app_dd_apm_env" {
  type        = string
  description = "Environment Tag for APM."
  default     = ""
}

variable "app_dd_apm_receiver_socket" {
  type        = string
  description = "Path to the APM Receiver Socket."
  default     = ""
}

variable "app_dd_apm_non_local_traffic" {
  type        = bool
  description = "Toggle to enable the APM Agent to listen for non-local traffic."
  default     = false
}

variable "app_dd_apm_dd_url" {
  type        = string
  description = "Hostname of the APM Server to use."
  default     = ""
}

# setting this to `0` does not stop sampling, it only stops sending traces to the Intake.
variable "app_dd_apm_max_tps" {
  type        = number
  description = "Traces Per Second to sample."
  default     = 10
}

variable "app_dd_apm_error_tps" {
  type        = number
  description = "Target Error Trace chunks to receive per second."
  default     = 10
}

variable "app_dd_apm_max_eps" {
  type        = number
  description = "Maximum Events per second to sample."
  default     = 200
}

# Memory usage-limiting is disabled on Agent-level, as this is managed by Nomad resource configuration.
variable "app_dd_apm_max_memory" {
  type        = number
  description = "Memory the Agent is allowed to use."
  default     = 0
}

# CPU rate-limiting is disabled on Agent-level, as this is managed by Nomad resource configuration.
variable "app_dd_apm_max_cpu_percent" {
  type        = number
  description = "CPU Percentage the Agent is allowed to use."
  default     = 0
}

# see https://docs.datadoghq.com/tracing/setup_overview/configure_data_security/#replace-rules-for-tag-filtering
variable "app_dd_apm_replace_tags" {
  type        = list(object({
    name    = string
    pattern = string
    repl    = string
  }))

  description = "List of Rule Objects to replace or remove certain Resources or Tags containing sensitive information."
}

# example value: "(GET|POST) /healthcheck"
variable "app_dd_apm_ignore_resources" {
  type        = list(string)
  description = "List of Exclusions of Regular Expressions to disable certain traces based on their resource name."
  default     = []
}

variable "app_dd_apm_log_file" {
  type        = string
  description = "Path to APM Agent Log file."
  default     = ""
}

variable "app_dd_apm_log_throttling" {
  type        = bool
  description = "Toggle to limit the total number of warnings and errors to 10 for every ten-second interval."
  default     = true
}

# see https://docs.datadoghq.com/tracing/troubleshooting/agent_rate_limits/#max-connection-limit
variable "app_dd_apm_connection_limit" {
  type        = number
  description = "Connection Limit for the APM Agent."
  default     = 2000
}

# for OTel Traces and top-level spans, this flag must be enabled.
variable "app_dd_apm_compute_stats_by_span_kind" {
  type        = bool
  description = "Toggle to enable additional stats computation check on Spans."
  default     = false
}

variable "app_dd_apm_peer_service_aggregation" {
  type        = bool
  description = "Toggle to enable `peer.service` aggregation in the Agent."
  default     = false
}

variable "app_dd_apm_features" {
  type        = list(string)
  description = "List of Beta APM Features to enable."
  default     = []
}

###################################################################
# Process Collection Configuration                                #
# see https://docs.datadoghq.com/graphing/infrastructure/process/ #
###################################################################

variable "app_dd_process_config_log_file" {
  type        = string
  description = "Path to Process Agent Log file."
  default     = ""
}

variable "app_dd_process_config_intervals_container" {
  type        = number
  description = "Interval (in seconds) at which the Agent runs each Check."
  default     = 10
}

variable "app_dd_process_config_intervals_container_realtime" {
  type        = number
  description = "Interval (in seconds) at which the Agent runs each Container Check."
  default     = 2
}

variable "app_dd_process_config_intervals_process" {
  type        = number
  description = "Interval (in seconds) at which the Agent runs each Process Check."
  default     = 10
}

variable "app_dd_process_config_intervals_process_realtime" {
  type        = number
  description = "Interval (in seconds) at which the Agent runs each Realtime Check."
  default     = 2
}

variable "app_dd_process_config_blacklist_patterns" {
  type        = list(string)
  description = "List of Regular Expressions to exclude extra processes with."
  default     = []
}

variable "app_dd_process_config_queue_size" {
  type        = number
  description = "Number of Check Results to buffer in memory when a POST to the Intake Server fails."
  default     = 256
}

variable "app_dd_process_config_process_queue_bytes" {
  type        = number
  description = "Amount of Data (in bytes) to buffer in memory when a POST to the Intake Server fails."
  default     = 60000000
}

variable "app_dd_process_config_rt_queue_size" {
  type        = number
  description = "Number of Realtime Check Results to buffer in memory when a POST to the Intake Server fails."
  default     = 5
}

variable "app_dd_process_config_max_per_message" {
  type        = number
  description = "Maximum Number of Processes or Containers to send per message."
  default     = 100
}

variable "app_dd_process_config_scrub_args" {
  type        = bool
  description = "Toggle to scrub sensitive data from the Live Processes page."
  default     = true
}

# See https://docs.datadoghq.com/graphing/infrastructure/process/#process-arguments-scrubbing
variable "app_dd_process_config_custom_sensitive_words" {
  type        = list(string)
  description = "List of Strings of sensitive words to merge with Datadog defaults."

  default     = [
    "access_key",
    "secret_access_key",
    "*token",
    "*pass*d*",
  ]
}

variable "app_dd_process_config_disable_realtime" {
  type        = bool
  description = "Toggle to disable Realtime Process and Container Checks."
  default     = false
}

#############################################
## Security Agent Compliance Configuration ##
#############################################

variable "app_dd_compliance_config_enabled" {
  type        = bool
  description = "Toggle to enable Cloud Security Posture Management (CSPM)."
  default     = false
}

variable "app_dd_compliance_config_dir" {
  type        = string
  description = "Path to the directory containing Compliance Checks configuration files."
  default     = "/etc/datadog-agent/compliance.d"
}

# see https://golang.org/pkg/time/#ParseDuration for options
variable "app_dd_compliance_config_check_interval" {
  type        = string
  description = "Check Interval (in minutes) for Compliance Checks."
  default     = "20m"
}

variable "app_dd_compliance_config_check_max_events_per_run" {
  type        = number
  description = "Maximum number of events to send per Compliance Checks run."
  default     = 100
}

########################################################
# DogStatsD Configuration                              #
# see https://docs.datadoghq.com/developers/dogstatsd/ #
########################################################

# `DD_USE_DOGSTATS` is set to `true` automatically, if DogStatsD is specified in `var.ports`

# defaults to IPv4, but can be set to `::1` to enable IPv6
variable "app_dd_bind_host" {
  type        = string
  description = "Host to listen on for DogStatsD and Trace Agent traffic."
  default     = "127.0.01"
}

variable "app_dd_dogstatsd_socket" {
  type        = string
  description = "Path to the DogStatsD Socket."
  default     = ""
}

# when running DogStatsD in a container, host PID mode (e.g. with `--pid=host`) is required
variable "app_dd_dogstatsd_origin_detection" {
  type        = bool
  description = "Toggle to tag Container Metadata Metrics with DogStatsD."
  default     = false
}

variable "app_dd_dogstatsd_origin_detection_client" {
  type        = bool
  description = "Toggle to use a client-provided Container ID to enrich Metrics, Events, and Service Checks with Container Tags."
  default     = false
}

variable "app_dd_dogstatsd_buffer_size" {
  type        = number
  description = "Buffer size (in bytes) to use for receiving StatsD packets."
  default     = 8192
}

variable "app_dd_dogstatsd_non_local_traffic" {
  type        = bool
  description = "Toggle to enable non-local UDP traffic for DogStatsD."
  default     = true
}

variable "app_dd_dogstatsd_stats_enable" {
  type        = bool
  description = "Toggle to enable publishing of DogStatsD-internal stats as `expvars`."
  default     = false
}

variable "app_dd_dogstatsd_queue_size" {
  type        = number
  description = "Size of the internal queue of the DogStatsD server."
  default     = 1024
}

variable "app_dd_dogstatsd_stats_buffer" {
  type        = number
  description = "Size of the internal buffer of the DogStatsD server."
  default     = 10
}

variable "app_dd_dogstatsd_so_rcvbuf" {
  type        = number
  description = "Size (in bytes) of the socket receive buffer for DogStatsD."
  default     = 0
}

# metrics can be visualized using the `dogstatsd-stats` command
variable "app_dd_dogstatsd_metrics_stats_enable" {
  type        = bool
  description = "Toggle to enable collection of basic statistics about the metrics processed by DogStatsD."
  default     = false
}

variable "app_dd_dogstatsd_tags" {
  type        = list(string)
  description = "Additional Tags to append to all Metrics, Events, and Service Checks received by DogStatsD."
  default     = []
}

# TODO: DD_DOGSTATSD_MAPPER_PROFILES

variable "app_dd_dogstatsd_mapper_cache_size" {
  type        = number
  description = "Size of cache of DogStats Mapper."
  default     = 1000
}

variable "app_dd_dogstatsd_entity_id_precedence" {
  type        = bool
  description = "Toggle to disable enriching Metrics with Tags from `origin detection`."
  default     = false
}

variable "app_dd_dogstatsd_no_aggregation_pipeline" {
  type        = bool
  description = "Toggle to enable No-Aggregation Pipeline in DogStatsD."
  default     = true
}

variable "app_dd_dogstatsd_no_aggregation_pipeline_batch_size" {
  type        = number
  description = "Number of Metrics to send in each payload of the No-Aggregation Pipeline."
  default     = 256
}

variable "app_dd_statsd_metric_namespace" {
  type        = string
  description = "Namespace for all StatsD Metrics for this Agent."
  default     = ""
}

#####################################################
# JMX Configuration                                 #
# see https://docs.datadoghq.com/integrations/java/ #
#####################################################

variable "app_dd_jmx_custom_jars" {
  type        = list(string)
  description = "List of custom JARs to load for JMXFetch."
  default     = []
}

variable "app_dd_jmx_use_cgroup_memory_limit" {
  type        = bool
  description = "Toggle to use cgroup memory limit."
  default     = false
}

variable "app_dd_jmx_use_container_support" {
  type        = bool
  description = "Toggle to enable automatic detection of Container-specific configuration (instead of querying the OS)."
  default     = false
}

variable "app_dd_jmx_log_file" {
  type        = string
  description = "Path to JMXFetch Log file."
  default     = ""
}

variable "app_dd_jmx_max_restarts" {
  type        = number
  description = "Number of allowed restarts for JMX before stopping."
  default     = 3
}

variable "app_dd_jmx_restart_interval" {
  type        = number
  description = "Duration (in seconds) of the restart interval."
  default     = 5
}

variable "app_dd_jmx_check_period" {
  type        = number
  description = "Duration (in milliseconds) of the period for Check Collections."
  default     = 15000
}

variable "app_dd_jmx_thread_pool_size" {
  type        = number
  description = "Maximum concurrency for JMXFetch."
  default     = 3
}

variable "app_dd_jmx_collection_timeout" {
  type        = number
  description = "Timeout (in seconds) for JMX collection before stopping."
  default     = 60
}

# setting this to `1` will process instance reconnections serially
variable "app_dd_jmx_reconnection_thread_pool_size" {
  type        = number
  description = "Maximum concurrency for JMXFetch reconnection attempts."
  default     = 3
}

variable "app_dd_jmx_reconnection_timeout" {
  type        = number
  description = "Timeout (in seconds) for instance reconnection before stopping."
  default     = 60
}

variable "app_dd_jmx_statsd_telemetry_enabled" {
  type        = bool
  description = "Toggle to enable JMXFetch StatsD Client Telemetry."
  default     = false
}

##############################################
# Logging Configuration                      #
# see https://docs.datadoghq.com/agent/logs/ #
##############################################

# "valid values are: `trace`, `debug`, `info`, `warn`, `error`, `critical`, and `off`"
variable "app_dd_log_level" {
  type        = string
  description = "Log Level for the Datadog Agent."
  default     = "info"
}

# "see https://docs.datadoghq.com/agent/guide/agent-log-files/"
variable "app_dd_log_file" {
  type        = string
  description = "Path to Agent (primary) Log file."
  default     = ""
}

variable "app_dd_log_format_json" {
  type        = bool
  description = "Toggle to format Agent Logs as JSON."
  default     = false
}

variable "app_dd_log_to_console" {
  type        = bool
  description = "Toggle to enable Agent Logging to `stdout`."
  default     = true
}

variable "app_dd_disable_file_logging" {
  type        = bool
  description = "Toggle to disable file-based Logging."
  default     = false
}

# value may be provided in bytes (e.g. `10485760`) or as a string (e.g. `10MB`)
variable "app_dd_log_file_max_size" {
  type        = string
  description = "Maximum Size of a single Agent Log file."
  default     = "10MB"
}

variable "app_dd_log_file_max_rolls" {
  type        = number
  description = "Maximum amount of Agent Log files to keep."
  default     = 1
}

variable "app_dd_log_to_syslog" {
  type        = bool
  description = "Toggle to enable Agent Logging to `syslog`."
  default     = false
}

variable "app_dd_syslog_uri" {
  type        = string
  description = "Custom Remote Syslog URI."
  default     = ""
}

variable "app_dd_syslog_rfc" {
  type        = bool
  description = "Toggle to enable RFC5424-compliant formatting for Agent Logs."
  default     = false
}

variable "app_dd_syslog_pem" {
  type        = string
  description = "Path to PEM certificate for TLS-enabled Syslog."
  default     = ""
}

variable "app_dd_syslog_key" {
  type        = string
  description = "Path to PEM key for TLS-enabled Syslog."
  default     = ""
}

variable "app_dd_syslog_tls_verify" {
  type        = bool
  description = "Toggle to enable TLS verification for Syslog."
  default     = true
}

variable "app_dd_log_format_rfc3339" {
  type        = bool
  description = "Toggle to enable RFC3339-compliant formatting for Agent Logs."
  default     = false
}

variable "app_dd_log_all_goroutines_when_unhealthy" {
  type        = bool
  description = "Toggle to enable logging of all Go Routines when the Agent is unhealthy."
  default     = false
}

##############################################################
# Autoconfig Configuration                                   #
# see https://docs.datadoghq.com/containers/guide/auto_conf/ #
##############################################################

variable "app_dd_autoconf_template_dir" {
  type        = string
  description = "Path to the directory containing Autoconfig configuration files."
  default     = ""
}

variable "app_dd_autoconf_config_files_poll" {
  type        = bool
  description = "Toggle to enable polling for new Autoconfig configuration files"
  default     = false
}

variable "app_dd_autoconf_config_files_poll_interval" {
  type        = number
  description = "Interval (in seconds) at which the Agent should poll for new Autoconfig configuration files."
  default     = 60
}

# TODO: `DD_CONFIG_PROVIDERS`

variable "app_dd_extra_config_providers" {
  type        = list(string)
  description = "List of additional Config Providers to enable."
  default     = []
}

variable "app_dd_autoconfig_exclude_features" {
  type        = list(string)
  description = "List of features to exclude from Autoconfig."
  default     = []
}

# "relevant values are: `containerd`, `cri`, `docker`, and `orcherstratorexplorer`"
variable "app_dd_autoconfig_include_features" {
  type        = list(string)
  description = "Activate Autoconfig features as if they were discovered by autodiscovery."
  default     = []
}

##############################################################################
# Container Autodiscovery Configuration                                      #
# see https://docs.datadoghq.com/containers/guide/ad_identifiers/?tab=docker #
##############################################################################

variable "app_dd_container_cgroup_root" {
  type        = string
  description = "Path to the `cgroup` root directory to get Container Metrics from."
  default     = "/host/sys/fs/cgroup/"
}

variable "app_dd_container_proc_root" {
  type        = string
  description = "Path to the `proc` root directory to get Container Metrics from."
  default     = "/host/proc"
}

variable "app_dd_listeners" {
  type        = list(string)
  description = "List of Listeners to enable."
  default     = []
}

variable "app_dd_extra_listeners" {
  type        = list(string)
  description = "List of additional Listeners to enable."
  default     = []
}

# "see https://docs.datadoghq.com/agent/guide/autodiscovery-management/"
variable "app_dd_ac_exclude" {
  type        = list(string)
  description = "List of Containers to exclude from Metrics and Auto Discovery."
  default     = []
}

variable "app_dd_ac_include" {
  type        = list(string)
  description = "List of Containers to include in Metrics and Auto Discovery."
  default     = []
}

variable "app_dd_exclude_pause_container" {
  type        = bool
  description = "Toggle to exclude Orchestrator-specific Pause Containers."
  default     = true
}

variable "app_dd_docker_query_timeout" {
  type        = number
  description = "Timeout (in seconds) for Docker daemon queries."
  default     = 5
}

variable "app_dd_ad_config_poll_interval" {
  type        = number
  description = "Interval (in seconds) to check for new Auto Discovery configurations."
  default     = 10
}

##############################################
# Container Detection                        #
# see https://docs.datadoghq.com/containers/ #
##############################################

variable "app_dd_container_cgroup_prefix" {
  type        = string
  description = "Prefix for cgroups to more accurately detect Container Processes."
  default     = "/docker/"
}

# keys prefixed with `+` will only be added to high cardinality Metrics.
variable "app_dd_docker_labels_as_tags" {
  type        = list(string)
  description = "Key-Value Pairs of Docker Labels to be set as Tags."
  default     = []
}

variable "app_dd_docker_env_as_tags" {
  type        = list(string)
  description = "List of Docker Environment Variables to extract and set as Metric Tags."
  default     = []
}

# supported runtimes are Containerd and Docker
variable "app_dd_container_env_as_tags" {
  type        = list(string)
  description = "List of Container Runtime Environment Variables to extract and set as Metric Tags."
  default     = []
}

# keys prefixed with `+` will only be added to high cardinality Metrics.
variable "app_dd_container_labels_as_tags" {
  type        = list(string)
  description = "Key-Value Pairs of Container Labels to be set as Tags."
  default     = []
}

###########################################################
# Containerd Integration Configuration                    #
# see https://docs.datadoghq.com/integrations/containerd/ #
###########################################################

variable "app_dd_cri_socket_path" {
  type        = string
  description = "Path to the `containerd` socket."
  default     = "/var/run/containerd/containerd.sock"
}

variable "app_dd_cri_query_timeout" {
  type        = number
  description = "Timeout (in seconds) for querying the `containerd` API."
  default     = 5
}

#################################################
# OpenTelemetry Configuration                   #
# see https://docs.datadoghq.com/opentelemetry/ #
#################################################

variable "app_dd_otlp_config_receiver_protocols_grpc_endpoint" {
  type        = string
  description = "OTLP (gRPC) Listener Endpoint."
  default     = "0.0.0.0:4317"
}

# valid values are: `tcp`, `udp`, `ip`, `unix`, `unixgram`, `unixpacket`
variable "app_dd_otlp_config_receiver_protocols_grpc_transport" {
  type        = string
  description = "OTLP (gRPC) Listener Transport Protocol."
  default     = "tcp"
}

variable "app_dd_otlp_config_receiver_protocols_http_endpoint" {
  type        = string
  description = "OTLP (HTTP) Listener Endpoint."
  default     = "0.0.0.0:4318"
}

variable "app_dd_otlp_config_metrics_enabled" {
  type        = bool
  description = "Toggle to disable Metrics Support in the OTLP Ingest Endpoint."
  default     = true
}

variable "app_dd_otlp_config_metrics_resource_attributes_as_tags" {
  type        = bool
  description = "Toggle to add all Resource Attributes of a Metric to its Metric Tags."
  default     = false
}

variable "app_dd_otlp_config_metrics_instrumentation_scope_metadata_as_tags" {
  type        = bool
  description = "Toggle to add Metadata about the Instrumentation Scope that created a Metric."
  default     = false
}

# valid values are `low`, `orchestrator`, `high`
variable "app_dd_otlp_config_metrics_tag_cardinality" {
  type        = string
  description = "Level of Granularity of Tags to send for OTLP Metrics."
  default     = "low"
}

variable "app_dd_otlp_config_metrics_delta_ttl" {
  type        = number
  description = "Time (in seconds) to keep values in memory for calculating deltas for cumulative monotonic Metrics."
  default     = 3600
}

# valid values are: `distributions`, `nobuckets`, `counters`
variable "app_dd_otlp_config_metrics_histograms_mode" {
  type        = string
  description = "Histogram Reporting Mode."
  default     = "distributions"
}

variable "app_dd_otlp_config_metrics_histograms_send_aggregation_metrics" {
  type        = bool
  description = "Toggle to report `sum`, `count,` `min`, and `max` as separate Histogram Metrics."
  default     = false
}

# valid values are `to_delta`, `raw_value`
variable "app_dd_otlp_config_metrics_sums_cumulative_monotonic_mode" {
  type        = string
  description = "Strategy to use when reporting cumulative monotonic Sums."
  default     = "to_delta"
}

# valid values are `noquantiles`, `gauges`
variable "app_dd_otlp_config_metrics_summaries_mode" {
  type        = string
  description = "Strategy to use when reporting Summaries."
  default     = "gauges"
}

variable "app_dd_otlp_config_traces_enabled" {
  type        = bool
  description = "Toggle to disable Traces support in the OTLP Ingest Endpoint."
  default     = true
}

variable "app_dd_otlp_config_traces_span_name_as_resource_name" {
  type        = bool
  description = "Toggle to enable use of OpenTelemetry Span Name as Datadog Resource Name."
  default     = false
}

# example entry `"instrumentation:express.server": "express"`
variable "app_dd_otlp_config_traces_span_name_remappings" {
  type        = list(string)
  description = "List of Span Name Remappings to apply to OpenTelemetry Span Names."
  default     = []
}

variable "app_dd_otlp_config_traces_probabilistic_sampler_sampling_percentage" {
  type        = number
  description = "Percentage of Traces to ingest."
  default     = 100
}

# valid values are `basic`, `normal`, and `detailed`"
variable "app_dd_otlp_config_debug_verbosity" {
  type        = string
  description = "Verbosity of Debug Logs when Datadog Agent receives OTLP Traces and Metrics."
  default     = "normal"
}

#####################################
## Pack-specifc Agent Configuration #
#####################################

# Tags that are attached in-app to every metric, event, log, trace, and service check emitted by this Agent.
# see https://docs.datadoghq.com/tagging/
variable "dd_tags" {
  type        = list(string)
  description = "List of Strings of Host Tags."

  default = [
    "orchestrator:nomad",
    "availability-zone:$${NOMAD_DC}",
    "region:$${NOMAD_REGION}",
    "service:$${NOMAD_JOB_NAME}",
  ]
}

variable "include_nomad_tags" {
  type        = bool
  description = "Toggle to include Nomad-specific Tags as part of the `DD_EXTRA_TAGS` environment variable."
  default     = true
}

variable "nomad_tags" {
  type        = list(string)
  description = "List of Nomad-specific Host Tags."

  default = [
    "nomad-dc:$${NOMAD_DC}",
    "nomad-group-name:$${NOMAD_GROUP_NAME}",
    "nomad-job-id:$${NOMAD_JOB_ID}",
    "nomad-job-name:$${NOMAD_JOB_NAME}",
    "nomad-namespace:$${NOMAD_NAMESPACE}",
    "nomad-region:$${NOMAD_REGION}",
    "nomad-task-name:$${NOMAD_TASK_NAME}",
  ]
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#datacenters
variable "datacenters" {
  type        = list(string)
  description = "Eligible Datacenters for the Task."

  default = [
    "*"
  ]
}

variable "driver" {
  type        = string
  description = "Driver to use for the Job."
  default     = "raw_exec"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/ephemeral_disk
variable "ephemeral_disk" {
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

variable "group_name" {
  type        = string
  description = "Name for the Group."
  default     = "datadog_agent"
}

variable "nomad_job_name" {
  type        = string
  description = "Name for the Job."

  # value will be truncated to 63 characters when necessary
  default = "datadog_agent"
}

variable "nomad_group_tags" {
  type        = list(string)
  description = "List of Tags for the Job."

  default = [
    "datadog",
    "datadog-agent",
  ]
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#namespace
variable "namespace" {
  type        = string
  description = "Namespace for the Job."
  default     = "default"
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/network#network-modes
variable "network_mode" {
  type        = string
  description = "Network Mode for the Job."
  default     = "host"
}

variable "nomad_group_ports" {
  type = map(object({
    name           = string
    path           = string
    port           = number
    protocol       = string
    type           = string
    host_network   = string
    check_interval = string
    check_timeout  = string
  }))

  description = "Port Configuration for the Application."

  default = {
    # port for Go-Expvar Server
    # see https://docs.datadoghq.com/integrations/go_expvar/?tab=host
    expvar = {
      name           = "datadog_agent_expvar"
      path           = null
      port           = 5000
      protocol       = "tcp"
      type           = "tcp"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for the IPC API
    ipc = {
      name           = "datadog_agent_ipc"
      path           = "/agent/status"
      port           = 5001
      protocol       = "https"
      type           = "http"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for the Agent Browser UI
    # see https://docs.datadoghq.com/agent/basic_agent_usage/
    gui = {
      name           = "datadog_agent_gui"
      path           = "/"
      port           = 5002
      protocol       = "http"
      type           = "http"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for the APM Expvar Server
    apm_expvar = {
      name           = "datadog_agent_apm_expvar"
      path           = null
      port           = 5012
      protocol       = "tcp"
      type           = "tcp"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for the Agent Healthcheck
    healthcheck = {
      name           = "datadog_agent_healthcheck"
      path           = "/healthcheck"
      port           = 5555
      protocol       = "http"
      type           = "http"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for the debug endpoints for the Process Agent
    debug = {
      name           = "datadog_agent_debug"
      path           = null
      port           = 6062
      protocol       = "tcp"
      type           = "tcp"
      host_network   = null,
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for configuring runtime settings for the Process Agent
    config = {
      name           = "datadog_agent_config"
      path           = null
      port           = 6162
      protocol       = "tcp"
      type           = "tcp"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for DogStatsD
    dogstatsd = {
      name           = "datadog_agent_dogstatsd"
      path           = null
      port           = 8125
      protocol       = "tcp"
      type           = "tcp"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },

    # port for the APM Receiver
    apm_receiver = {
      name           = "datadog_agent_apm_receiver"
      path           = null
      port           = 8126
      protocol       = "tcp"
      type           = "tcp"
      host_network   = null
      check_interval = "30s"
      check_timeout  = "15s"
    },
  }
}

# see https://developer.hashicorp.com/nomad/docs/job-specification/job#priority
variable "priority" {
  type        = number
  description = "Priority for the Job."
  default     = 50
}

# see https://developer.hashicorp.com/nomad/docs/concepts/architecture#regions
variable "region" {
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
  default     = "datadog_agent"
}

variable "nomad_group_service_provider" {
  type        = string
  description = "Provider for the Group Service."
  default     = "nomad"
}

variable "restart_logic" {
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
  default     = "datadog_agent"
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
