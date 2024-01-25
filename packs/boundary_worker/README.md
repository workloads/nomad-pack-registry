# Nomad Pack: (HCP) Boundary Worker

![Nomad Pack: Boundary Worker](https://assets.workloads.io/nomad-pack-registry/boundary_worker.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: (HCP) Boundary Worker](#nomad-pack-hcp-boundary-worker)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Application](#application)
    * [Nomad](#nomad)
    * [Outputs](#outputs)
  * [Notes](#notes)
    * [Resource Sizing](#resource-sizing)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Nomad Task Driver(s) for [`raw_exec`](https://developer.hashicorp.com/nomad/docs/drivers/raw_exec)
- HCP Boundary Cluster ID _or_ HashiCorp Boundary Controller, see [Notes](#notes)

## Usage

The `boundary_worker` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/boundary_worker
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run boundary_worker --registry=workloads
```

<!-- BEGIN_PACK_DOCS -->

### Application

This section describes Application-specific configuration.

| Name                                     | Description                                                                                                                            | Default |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| app_boundary_helper_output_file_mode     | File Mode of the Output File created by the Boundary Helper binary.                                                                    | `"0644"` |
| app_boundary_helper_path                 | Path to the Boundary Helper binary.                                                                                                    | `"boundary-helper"` |
| app_cors_allowed_origins                 | Allowed CORS Origins for the Boundary Worker.                                                                                          | `["*"]` |
| app_cors_enabled                         | Toggle to enable CORS support for the Boundary Worker.                                                                                 | `false` |
| app_disable_mlock                        | Toggle to disable mlock for the Boundary Worker. This setting may not be supported on all operating systems.                           | `true` |
| app_enable_hcp_boundary_support          | Toggle to enable HCP Boundary Support (and forego self-hosted Boundary Enterprise Cluster registration workflows.                      | `true` |
| app_initial_upstreams                    | List of hosts or IP addresses for reaching a Boundary Cluster.                                                                         | n/a |
| app_tls_cert_file                        | Specifies the path to the certificate for the Boundary Worker.                                                                         | n/a |
| app_tls_cipher_suites                    | Overridden List of supported ciphersuites for the Boundary Worker. Only relevant if `app_tls_max_version` is set to `tls12` or below.  | n/a |
| app_tls_client_ca_file                   | PEM-encoded Certificate Authority File used for checking the authenticity of tthe client for the Boundary Worker.                      | n/a |
| app_tls_disable                          | Toggle to disable TLS support for the Boundary Worker.                                                                                 | `true` |
| app_tls_key_file                         | Specifies the path to the private key for the certificate for the Boundary Worker.                                                     | n/a |
| app_tls_max_version                      | Specifies the maximum supported TLS version for the Boundary Worker.                                                                   | `"tls13"` |
| app_tls_min_version                      | Specifies the minimum supported TLS version for the Boundary Worker.                                                                   | `"tls13"` |
| app_tls_prefer_server_cipher_suites      | Toggle to enable preference for Server's ciphersuites over Client's ciphersuites for the Boundary Worker.                              | `false` |
| app_tls_require_and_verify_client_cert   | Toggle to enable client authentication for the listener for the Boundary Worker.                                                       | `false` |
| app_worker_description                   | Description for the Boundary Worker.                                                                                                   | `"Nomad-managed Boundary Worker."` |
| app_worker_name_prefix                   | Prefix for the Boundary Worker Name.                                                                                                   | `"nomad"` |

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                        | Default |
| --------------------------------- | -------------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.                | `1` |
| nomad_group_ephemeral_disk        | Ephemeral Disk Configuration for the Group.        | `{"migrate":true,"size":128,"sticky":true}` |
| nomad_group_name                  | Name for the Group.                                | `"boundary_worker"` |
| nomad_group_network_mode          | Network Mode for the Group.                        | `"host"` |
| nomad_group_ports                 | Port and Healthcheck Configuration for the Group.  | `{"ops":{"check_interval":"30s","check_timeout":"15s","host_network":null,"name":"boundary_worker_ops","path":"/health","port":9203,"protocol":"http","type":"http"},"proxy":{"check_interval":"30s","check_timeout":"15s","host_network":null,"name":"boundary_worker_proxy","path":null,"port":9202,"protocol":"tcp","type":"tcp"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                       | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.                 | `"boundary_worker"` |
| nomad_group_service_provider      | Provider of the Service for the Group.             | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                        | `["boundary","boundary-workers"]` |
| nomad_group_volumes               | Volumes for the Group.                             | `{}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.                  | `["*"]` |
| nomad_job_name                    | Name for the Job.                                  | `"boundary_worker"` |
| nomad_job_namespace               | Namespace for the Job.                             | `"default"` |
| nomad_job_priority                | Priority for the Job.                              | `10` |
| nomad_job_region                  | Region for the Job.                                | `"global"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.                   | `true` |
| nomad_task_driver                 | Driver to use for the Task.                        | `"raw_exec"` |
| nomad_task_name                   | Name for the Task.                                 | `"boundary_worker"` |
| nomad_task_resources              | Resource Limits for the Task.                      | `{"cores":null,"cpu":500,"memory":512,"memory_max":1024}` |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

### Resource Sizing

For hardware sizing of the underlying Nomad Agents that are designed to run the Boundary Worker in this Nomad Pack, see the [HCP Boundary Self-managed Worker sizing guidelines](https://developer.hashicorp.com/hcp/docs/boundary/self-managed-workers/size-self-managed-workers#sizing-guidelines-for-self-managed-workers).

## Author Information

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
