# Nomad Pack: Datadog Agent

![Nomad Pack: Datadog Agent](https://assets.workloads.io/nomad-pack-registry/datadog_agent.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Datadog Agent](#nomad-pack-datadog-agent)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
    * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.5.0` or newer
- HashiCorp nomad-pack `0.0.1` or newer
- Nomad Task Driver(s) for [`raw_exec`](https://developer.hashicorp.com/nomad/docs/drivers/raw_exec)

## Usage

The `datadog_agent` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/datadog_agent
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run datadog_agent --registry=workloads
```

> **Note**
>
> For a more detailed description on how to use Nomad Pack, see [this guide](https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-intro#basic-use).

<!-- BEGIN_PACK_DOCS -->
### Inputs

| Name | Description | Type |
|------|-------------|------|
| app_dd_ac_exclude | List of Containers to exclude from Metrics and Auto Discovery. | `list(string)` |
| app_dd_ac_include | List of Containers to include in Metrics and Auto Discovery. | `list(string)` |
| app_dd_ad_config_poll_interval | Interval (in seconds) to check for new Auto Discovery configurations. | `number` |
| app_dd_additional_checksd | Path to the directory containing additional Python checks. | `string` |
| app_dd_aggregator_buffer_size | Default Buffer Size for the Aggregator. | `number` |
| app_dd_aggregator_stop_timeout | Timeout (in seconds) for the Aggregator to flush data before stopping. | `number` |
| app_dd_apm_compute_stats_by_span_kind | Toggle to enable additional stats computation check on Spans. | `bool` |
| app_dd_apm_connection_limit | Connection Limit for the APM Agent. | `number` |
| app_dd_apm_dd_url | Hostname of the APM Server to use. | `string` |
| app_dd_apm_enabled | Toggle to enable the APM Agent. | `bool` |
| app_dd_apm_env | Environment Tag for APM. | `string` |
| app_dd_apm_error_tps | Target Error Trace chunks to receive per second. | `number` |
| app_dd_apm_features | List of Beta APM Features to enable. | `list(string)` |
| app_dd_apm_ignore_resources | List of Exclusions of Regular Expressions to disable certain traces based on their resource name. | `list(string)` |
| app_dd_apm_log_file | Path to APM Agent Log file. | `string` |
| app_dd_apm_log_throttling | Toggle to limit the total number of warnings and errors to 10 for every ten-second interval. | `bool` |
| app_dd_apm_max_cpu_percent | CPU Percentage the Agent is allowed to use. | `number` |
| app_dd_apm_max_eps | Maximum Events per second to sample. | `number` |
| app_dd_apm_max_memory | Memory the Agent is allowed to use. | `number` |
| app_dd_apm_max_tps | Traces Per Second to sample. | `number` |
| app_dd_apm_non_local_traffic | Toggle to enable the APM Agent to listen for non-local traffic. | `bool` |
| app_dd_apm_peer_service_aggregation | Toggle to enable `peer.service` aggregation in the Agent. | `bool` |
| app_dd_apm_receiver_socket | Path to the APM Receiver Socket. | `string` |
| app_dd_apm_replace_tags | List of Rule Objects to replace or remove certain Resources or Tags containing sensitive information. | <pre>list(object({<br>    name    = string<br>    pattern = string<br>    repl    = string<br>  }))</pre> |
| app_dd_auto_exit_noprocess_enabled | Toggle to enable the `noprocess` method. | `bool` |
| app_dd_auto_exit_noprocess_excluded_processes | List of Regular Expressions to exclude extra processes with. | `list(string)` |
| app_dd_auto_exit_validation_period | Delay (in seconds) for "auto exit" validation before exiting. | `number` |
| app_dd_autoconf_config_files_poll | Toggle to enable polling for new Autoconfig configuration files | `bool` |
| app_dd_autoconf_config_files_poll_interval | Interval (in seconds) at which the Agent should poll for new Autoconfig configuration files. | `number` |
| app_dd_autoconf_template_dir | Path to the directory containing Autoconfig configuration files. | `string` |
| app_dd_autoconfig_exclude_features | List of features to exclude from Autoconfig. | `list(string)` |
| app_dd_autoconfig_include_features | Activate Autoconfig features as if they were discovered by autodiscovery. | `list(string)` |
| app_dd_azure_hostname_style | valid values are `os`, `name`, `name_and_resource_group`, `full`, `vmid` | `string` |
| app_dd_bind_host | Host to listen on for DogStatsD and Trace Agent traffic. | `string` |
| app_dd_check_runners | Number of concurrent Check Runners available for execution. | `number` |
| app_dd_checks_tag_cardinality | Configure the level of granularity of Tags to send for checks Metrics and Events. | `string` |
| app_dd_cloud_provider_metadata | List of CSPs to query metadata endpoints for | `list(string)` |
| app_dd_collect_ec2_tags | Toggle to collect AWS EC2 metadata as Host Tags. | `bool` |
| app_dd_collect_ec2_tags_use_imds | Toggle to use IMDS (instead of EC2 API) to collect AWS EC2 metadata. | `bool` |
| app_dd_collect_gce_tags | Toggle to collect GCP GCE metadata as Host Tags. | `bool` |
| app_dd_compliance_config_check_interval | Check Interval (in minutes) for Compliance Checks. | `string` |
| app_dd_compliance_config_check_max_events_per_run | Maximum number of events to send per Compliance Checks run. | `number` |
| app_dd_compliance_config_dir | Path to the directory containing Compliance Checks configuration files. | `string` |
| app_dd_compliance_config_enabled | Toggle to enable Cloud Security Posture Management (CSPM). | `bool` |
| app_dd_confd_path | Path to the directory containing `checks.d` configuration files. | `string` |
| app_dd_container_cgroup_prefix | Prefix for cgroups to more accurately detect Container Processes. | `string` |
| app_dd_container_cgroup_root | Path to the `cgroup` root directory to get Container Metrics from. | `string` |
| app_dd_container_env_as_tags | List of Container Runtime Environment Variables to extract and set as Metric Tags. | `list(string)` |
| app_dd_container_labels_as_tags | Key-Value Pairs of Container Labels to be set as Tags. | `list(string)` |
| app_dd_container_proc_root | Path to the `proc` root directory to get Container Metrics from. | `string` |
| app_dd_cri_query_timeout | Timeout (in seconds) for querying the `containerd` API. | `number` |
| app_dd_cri_socket_path | Path to the `containerd` socket. | `string` |
| app_dd_disable_file_logging | Toggle to disable file-based Logging. | `bool` |
| app_dd_disable_py3_validation | Toggle to disable Python 3 validation of Python checks. | `bool` |
| app_dd_docker_env_as_tags | List of Docker Environment Variables to extract and set as Metric Tags. | `list(string)` |
| app_dd_docker_labels_as_tags | Key-Value Pairs of Docker Labels to be set as Tags. | `list(string)` |
| app_dd_docker_query_timeout | Timeout (in seconds) for Docker daemon queries. | `number` |
| app_dd_dogstatsd_buffer_size | Buffer size (in bytes) to use for receiving StatsD packets. | `number` |
| app_dd_dogstatsd_entity_id_precedence | Toggle to disable enriching Metrics with Tags from `origin detection`. | `bool` |
| app_dd_dogstatsd_mapper_cache_size | Size of cache of DogStats Mapper. | `number` |
| app_dd_dogstatsd_metrics_stats_enable | Toggle to enable collection of basic statistics about the metrics processed by DogStatsD. | `bool` |
| app_dd_dogstatsd_no_aggregation_pipeline | Toggle to enable No-Aggregation Pipeline in DogStatsD. | `bool` |
| app_dd_dogstatsd_no_aggregation_pipeline_batch_size | Number of Metrics to send in each payload of the No-Aggregation Pipeline. | `number` |
| app_dd_dogstatsd_non_local_traffic | Toggle to enable non-local UDP traffic for DogStatsD. | `bool` |
| app_dd_dogstatsd_origin_detection | Toggle to tag Container Metadata Metrics with DogStatsD. | `bool` |
| app_dd_dogstatsd_origin_detection_client | Toggle to use a client-provided Container ID to enrich Metrics, Events, and Service Checks with Container Tags. | `bool` |
| app_dd_dogstatsd_queue_size | Size of the internal queue of the DogStatsD server. | `number` |
| app_dd_dogstatsd_so_rcvbuf | Size (in bytes) of the socket receive buffer for DogStatsD. | `number` |
| app_dd_dogstatsd_socket | Path to the DogStatsD Socket. | `string` |
| app_dd_dogstatsd_stats_buffer | Size of the internal buffer of the DogStatsD server. | `number` |
| app_dd_dogstatsd_stats_enable | Toggle to enable publishing of DogStatsD-internal stats as `expvars`. | `bool` |
| app_dd_dogstatsd_tag_cardinality | Configure the level of granularity of Tags to send for DogStatsD Metrics and Events. | `string` |
| app_dd_dogstatsd_tags | Additional Tags to append to all Metrics, Events, and Service Checks received by DogStatsD. | `list(string)` |
| app_dd_ec2_metadata_timeout | Timeout (in milliseconds) on calls to the AWS EC2 metadata endpoints. | `number` |
| app_dd_ec2_prefer_imdsv2 | Toggle to use IMDSv2 to collect AWS EC2 metadata. | `bool` |
| app_dd_enable_gohai | Toggle to enable `gohai` collection of system data from the Agent. | `bool` |
| app_dd_enable_metadata_collection | Toggle to enable the collection of system metadata from the Agent. | `bool` |
| app_dd_env | Environment Name where the agent is running. | `string` |
| app_dd_exclude_ec2_tags | AWS EC2 tags to exclude from being collected as Host Tags. | `list(string)` |
| app_dd_exclude_gce_tags | GCP GCE tags to exclude from being collected as Host Tags. | `list(string)` |
| app_dd_exclude_pause_container | Toggle to exclude Orchestrator-specific Pause Containers. | `bool` |
| app_dd_extra_config_providers | List of additional Config Providers to enable. | `list(string)` |
| app_dd_extra_listeners | List of additional Listeners to enable. | `list(string)` |
| app_dd_flare_stripped_keys | Additional sensitive keys that should be scrubbed before sending an Agent Flare. | `list(string)` |
| app_dd_gce_metadata_timeout | Timeout (in milliseconds) on calls to the GCP GCE metadata endpoints. | `number` |
| app_dd_gce_send_project_id_tag | Toggle to send GCP Project Name and ID as Host Tag. | `bool` |
| app_dd_histogram_aggregates | Configure which aggregated value to compute. | `list(string)` |
| app_dd_histogram_copy_to_distribution | Toggle to copy Histogram values to Distribution Metrics for global distributions. | `bool` |
| app_dd_histogram_copy_to_distribution_prefix | Prefix to add to Distribution Metrics. | `string` |
| app_dd_histogram_percentiles | Configure which Percentiles are computed by the Agent. | `list(string)` |
| app_dd_hostname | Force-set the Hostname. | `string` |
| app_dd_hostname_fqdn | Toggle to use a FQDN instead of a short hostname. | `bool` |
| app_dd_inventories_configuration_enabled | Toggle to enable Agent to send its own configuration. | `bool` |
| app_dd_jmx_check_period | Duration (in milliseconds) of the period for Check Collections. | `number` |
| app_dd_jmx_collection_timeout | Timeout (in seconds) for JMX collection before stopping. | `number` |
| app_dd_jmx_custom_jars | List of custom JARs to load for JMXFetch. | `list(string)` |
| app_dd_jmx_log_file | Path to JMXFetch Log file. | `string` |
| app_dd_jmx_max_restarts | Number of allowed restarts for JMX before stopping. | `number` |
| app_dd_jmx_reconnection_thread_pool_size | Maximum concurrency for JMXFetch reconnection attempts. | `number` |
| app_dd_jmx_reconnection_timeout | Timeout (in seconds) for instance reconnection before stopping. | `number` |
| app_dd_jmx_restart_interval | Duration (in seconds) of the restart interval. | `number` |
| app_dd_jmx_statsd_telemetry_enabled | Toggle to enable JMXFetch StatsD Client Telemetry. | `bool` |
| app_dd_jmx_thread_pool_size | Maximum concurrency for JMXFetch. | `number` |
| app_dd_jmx_use_cgroup_memory_limit | Toggle to use cgroup memory limit. | `bool` |
| app_dd_jmx_use_container_support | Toggle to enable automatic detection of Container-specific configuration (instead of querying the OS). | `bool` |
| app_dd_listeners | List of Listeners to enable. | `list(string)` |
| app_dd_log_all_goroutines_when_unhealthy | Toggle to enable logging of all Go Routines when the Agent is unhealthy. | `bool` |
| app_dd_log_file | Path to Agent (primary) Log file. | `string` |
| app_dd_log_file_max_rolls | Maximum amount of Agent Log files to keep. | `number` |
| app_dd_log_file_max_size | Maximum Size of a single Agent Log file. | `string` |
| app_dd_log_format_json | Toggle to format Agent Logs as JSON. | `bool` |
| app_dd_log_format_rfc3339 | Toggle to enable RFC3339-compliant formatting for Agent Logs. | `bool` |
| app_dd_log_level | Log Level for the Datadog Agent. | `string` |
| app_dd_log_to_console | Toggle to enable Agent Logging to `stdout`. | `bool` |
| app_dd_log_to_syslog | Toggle to enable Agent Logging to `syslog`. | `bool` |
| app_dd_logs_config_batch_wait | Maximum time (in seconds) the Agent waits to fill each batch of Logs before sending. | `number` |
| app_dd_logs_config_compression_level | Compression Level for Log collection. | `number` |
| app_dd_logs_config_container_collect_all | Toggle to enable Log Collection for all Containers. | `bool` |
| app_dd_logs_config_dd_url | Hostname of the Logs Server to use. | `string` |
| app_dd_logs_config_file_wildcard_selection_mode | Strategy to use to prioritize wildcard matches if they exceed the open file limit. | `string` |
| app_dd_logs_config_force_use_http | Toggle to force the Agent to send Logs over insecure HTTP. | `bool` |
| app_dd_logs_config_logs_no_ssl | Toggle to disable TSL encryption for Log collection. | `bool` |
| app_dd_logs_config_open_files_limit | Maximum number of files that can be tailed in parallel. | `number` |
| app_dd_logs_config_processing_rules | List of Processing Rules to apply to all Logs | `list(string)` |
| app_dd_logs_config_use_compression | Toggle to enable Compression for Log collection. | `bool` |
| app_dd_logs_enabled | Toggle to enable Log collection for the Agent. | `bool` |
| app_dd_logs_force_use_tcp | Toggle to force the Agent to send Logs over TCP. | `bool` |
| app_dd_memtrack_enabled | Toggle to enable tracking of memory allocations made from the Python runtime loader. | `bool` |
| app_dd_min_tls_version | Minimum TLS version for Intake Server. | `string` |
| app_dd_no_proxy_nonexact_match | Toggle to enable more flexible `no_proxy` matching. | `bool` |
| app_dd_observability_pipelines_worker_logs_enabled | Toggle to enable forwarding of Logs to an Observability Pipelines Worker. | `bool` |
| app_dd_observability_pipelines_worker_logs_url | URL endpoint for the Observability Pipelines Worker to send Logs to. | `string` |
| app_dd_observability_pipelines_worker_metrics_enabled | Toggle to enable forwarding of Metrics to an Observability Pipelines Worker. | `bool` |
| app_dd_observability_pipelines_worker_metrics_url | URL endpoint for the Observability Pipelines Worker to send Metrics to. | `string` |
| app_dd_observability_pipelines_worker_traces_enabled | Toggle to enable forwarding of Traces to an Observability Pipelines Worker. | `bool` |
| app_dd_observability_pipelines_worker_traces_url | URL endpoint for the Observability Pipelines Worker to send Traces to. | `string` |
| app_dd_otlp_config_debug_verbosity | Verbosity of Debug Logs when Datadog Agent receives OTLP Traces and Metrics. | `string` |
| app_dd_otlp_config_metrics_delta_ttl | Time (in seconds) to keep values in memory for calculating deltas for cumulative monotonic Metrics. | `number` |
| app_dd_otlp_config_metrics_enabled | Toggle to disable Metrics Support in the OTLP Ingest Endpoint. | `bool` |
| app_dd_otlp_config_metrics_histograms_mode | Histogram Reporting Mode. | `string` |
| app_dd_otlp_config_metrics_histograms_send_aggregation_metrics | Toggle to report `sum`, `count,` `min`, and `max` as separate Histogram Metrics. | `bool` |
| app_dd_otlp_config_metrics_instrumentation_scope_metadata_as_tags | Toggle to add Metadata about the Instrumentation Scope that created a Metric. | `bool` |
| app_dd_otlp_config_metrics_resource_attributes_as_tags | Toggle to add all Resource Attributes of a Metric to its Metric Tags. | `bool` |
| app_dd_otlp_config_metrics_summaries_mode | Strategy to use when reporting Summaries. | `string` |
| app_dd_otlp_config_metrics_sums_cumulative_monotonic_mode | Strategy to use when reporting cumulative monotonic Sums. | `string` |
| app_dd_otlp_config_metrics_tag_cardinality | Level of Granularity of Tags to send for OTLP Metrics. | `string` |
| app_dd_otlp_config_receiver_protocols_grpc_endpoint | OTLP (gRPC) Listener Endpoint. | `string` |
| app_dd_otlp_config_receiver_protocols_grpc_transport | OTLP (gRPC) Listener Transport Protocol. | `string` |
| app_dd_otlp_config_receiver_protocols_http_endpoint | OTLP (HTTP) Listener Endpoint. | `string` |
| app_dd_otlp_config_traces_enabled | Toggle to disable Traces support in the OTLP Ingest Endpoint. | `bool` |
| app_dd_otlp_config_traces_probabilistic_sampler_sampling_percentage | Percentage of Traces to ingest. | `number` |
| app_dd_otlp_config_traces_span_name_as_resource_name | Toggle to enable use of OpenTelemetry Span Name as Datadog Resource Name. | `bool` |
| app_dd_otlp_config_traces_span_name_remappings | List of Span Name Remappings to apply to OpenTelemetry Span Names. | `list(string)` |
| app_dd_process_config_blacklist_patterns | List of Regular Expressions to exclude extra processes with. | `list(string)` |
| app_dd_process_config_custom_sensitive_words | List of Strings of sensitive words to merge with Datadog defaults. | `list(string)` |
| app_dd_process_config_disable_realtime | Toggle to disable Realtime Process and Container Checks. | `bool` |
| app_dd_process_config_intervals_container | Interval (in seconds) at which the Agent runs each Check. | `number` |
| app_dd_process_config_intervals_container_realtime | Interval (in seconds) at which the Agent runs each Container Check. | `number` |
| app_dd_process_config_intervals_process | Interval (in seconds) at which the Agent runs each Process Check. | `number` |
| app_dd_process_config_intervals_process_realtime | Interval (in seconds) at which the Agent runs each Realtime Check. | `number` |
| app_dd_process_config_log_file | Path to Process Agent Log file. | `string` |
| app_dd_process_config_max_per_message | Maximum Number of Processes or Containers to send per message. | `number` |
| app_dd_process_config_process_queue_bytes | Amount of Data (in bytes) to buffer in memory when a POST to the Intake Server fails. | `number` |
| app_dd_process_config_queue_size | Number of Check Results to buffer in memory when a POST to the Intake Server fails. | `number` |
| app_dd_process_config_rt_queue_size | Number of Realtime Check Results to buffer in memory when a POST to the Intake Server fails. | `number` |
| app_dd_process_config_scrub_args | Toggle to scrub sensitive data from the Live Processes page. | `bool` |
| app_dd_procfs_path | Path to the `procfs` file system. | `string` |
| app_dd_python3_linter_timeout | Timeout (in seconds) for Python 3 Compatibility validation when running Python 2 of Python checks. | `number` |
| app_dd_secret_backend_arguments | List of arguments to give to the Secret Backend Command at each run. | `list(string)` |
| app_dd_secret_backend_command | Path to a Command to execute to fetch Secrets. | `string` |
| app_dd_secret_backend_output_max_size | Size (in bytes) of the buffer used to store the Secrets Backend Command's response. Applies to `stdout` and `stderr`. | `number` |
| app_dd_secret_backend_remove_trailing_line_break | Toggle to remove trailing line breaks from Secrets returned by the Secret Backend Command. | `bool` |
| app_dd_secret_backend_skip_checks | Toggle to disable fetching Secrets for Check Configurations. | `bool` |
| app_dd_secret_backend_timeout | Timeout (in seconds) for the Secret Backend Command. | `number` |
| app_dd_server_timeout | Timeout (in seconds) for the IPC API Server. | `number` |
| app_dd_site | Intake Server to use. | `string` |
| app_dd_skip_ssl_validation | Toggle to skip validation of TLS Certificates. | `bool` |
| app_dd_statsd_metric_namespace | Namespace for all StatsD Metrics for this Agent. | `string` |
| app_dd_syslog_key | Path to PEM key for TLS-enabled Syslog. | `string` |
| app_dd_syslog_pem | Path to PEM certificate for TLS-enabled Syslog. | `string` |
| app_dd_syslog_rfc | Toggle to enable RFC5424-compliant formatting for Agent Logs. | `bool` |
| app_dd_syslog_tls_verify | Toggle to enable TLS verification for Syslog. | `bool` |
| app_dd_syslog_uri | Custom Remote Syslog URI. | `string` |
| app_dd_tracemalloc_debug | Toggle to enable debugging with `tracemalloc` for Python checks. | `bool` |
| app_dd_tracemalloc_exclude | List of Python checks to disable `tracemalloc` for, when `tracemalloc_debug` is true. | `list(string)` |
| app_dd_tracemalloc_include | List of Python checks to enable `tracemalloc` for, when `tracemalloc_debug` is true. | `list(string)` |
| app_dd_url | Hostname of the Intake Server to use. | `string` |
| app_dd_use_proxy_for_cloud_metadata | Toggle to remove CSP IPs from the transport's `no_proxy` list. | `bool` |
| app_dd_windows_use_pythonpath | Toggle to honour the value of the `PYTHONPATH` environment variable. Windows only. | `bool` |
| count | Count of Deployments for the Job. | `number` |
| datacenters | Eligible Datacenters for the Task. | `list(string)` |
| dd_tags | List of Strings of Host Tags. | `list(string)` |
| driver | Driver to use for the Job. | `string` |
| ephemeral_disk | Ephemeral Disk Configuration for the Application. | <pre>object({<br>    migrate = bool<br>    size    = number<br>    sticky  = bool<br>  })</pre> |
| group_name | Name for the Group. | `string` |
| include_nomad_tags | Toggle to include Nomad-specific Tags as part of the `DD_EXTRA_TAGS` environment variable. | `bool` |
| job_name | Name for the Job. | `string` |
| job_tags | List of Tags for the Job. | `list(string)` |
| namespace | Namespace for the Job. | `string` |
| network_mode | Network Mode for the Job. | `string` |
| nomad_tags | List of Nomad-specific Host Tags. | `list(string)` |
| ports | Port Configuration for the Application. | <pre>map(object({<br>    name           = string<br>    path           = string<br>    port           = number<br>    protocol       = string<br>    type           = string<br>    host_network   = string<br>    check_interval = string<br>    check_timeout  = string<br>  }))</pre> |
| priority | Priority for the Job. | `number` |
| region | Region for the Job. | `string` |
| resources | Resource Limits for the Application. | <pre>object({<br>    cpu        = number<br>    cores      = number<br>    memory     = number<br>    memory_max = number<br>  })</pre> |
| restart_logic | Restart Logic for the Application. | <pre>object({<br>    attempts = number<br>    interval = string<br>    delay    = string<br>    mode     = string<br>  })</pre> |
| service_name_prefix | Name for the Service. | `string` |
| service_provider | Provider for the Service. | `string` |
| task_name | Name for the Task. | `string` |
| verbose_output | Toggle to enable verbose output. | `bool` |
| volumes | Volumes for the Application. | <pre>map(object({<br>    name        = string<br>    type        = string<br>    destination = string<br>    read_only   = bool<br>  }))</pre> |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `verbose_output` is set to `true`.

### Notes

* Datadog Agents require an API key to transmit data to a Datadog Intake Server.
  This value is provided via the Nomad Variable `api_key`, which is stored at `nomad/jobs/datadog_agent`.

* The `dd_tags` variable is pre-configured to map Nomad Runtime Environment variables to common Datadog variables.

* Setting the `app_include_nomad_tags` variable to `true` will transmit Nomad-specifc tags (e.g.: Job, Task, Allocation data) as part of the Datadog Agent's payload.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
