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
    * [Using the Boundary CLI](#using-the-boundary-cli)
    * [Resource Sizing](#resource-sizing)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Nomad Task Driver(s) for [`raw_exec`](https://developer.hashicorp.com/nomad/docs/drivers/raw_exec)
- HCP Boundary Cluster ID, see [Notes](#notes)
- Boundary Controller Token, see [Notes](#notes)

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

| Name                                   | Description                                                                                                        | Default |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------- |
| app_boundary_helper_output_file_mode   | File Mode of the Output File created by the Boundary Helper Binary.                                                | `"0644"` |
| app_boundary_helper_path               | Path to the Boundary Helper Binary.                                                                                | `"/Users/ksatirli/Desktop/workloads/boundary-helper/dist/boundary-helper"` |
| app_enable_hcp_boundary_support        | Toggle to enable HCP Boundary Support (and forego self-hosted Boundary Enterprise Cluster registration workflows.  | `true` |
| app_initial_upstreams                  | Initial Upstreams for the Boundary Worker.                                                                         | n/a |
| app_worker_description                 | Description for the Boundary Worker.                                                                               | `"Nomad-managed Boundary Worker."` |
| app_worker_name_prefix                 | Prefix for the Boundary Worker Name.                                                                               | `"nomad"` |
| app_worker_tags                        | Tags for the Boundary Worker.                                                                                      | `["nomad-managed-worker","nomad-agent"]` |

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                  | Default |
| --------------------------------- | -------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.          | `1` |
| nomad_group_ephemeral_disk        | Ephemeral Disk Configuration for the Group.  | `{"migrate":true,"size":128,"sticky":true}` |
| nomad_group_name                  | Name for the Group.                          | `"boundary_worker"` |
| nomad_group_network_mode          | Network Mode for the Group.                  | `"host"` |
| nomad_group_ports                 | Port Configuration for the Group.            | `{"proxy":{"check_interval":"30s","check_timeout":"15s","host_network":null,"name":"boundary_worker_proxy","path":null,"port":9202,"protocol":"tcp","type":"tcp"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                 | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.           | `"boundary_worker"` |
| nomad_group_service_provider      | Provider of the Service for the Group.       | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                  | `["boundary","boundary-workers"]` |
| nomad_group_volumes               | Volumes for the Group.                       | `{}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.            | `["*"]` |
| nomad_job_name                    | Name for the Job.                            | `"boundary_worker"` |
| nomad_job_namespace               | Namespace for the Job.                       | `"default"` |
| nomad_job_priority                | Priority for the Job.                        | `10` |
| nomad_job_region                  | Region for the Job.                          | `"global"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.             | `true` |
| nomad_task_driver                 | Driver to use for the Task.                  | `"raw_exec"` |
| nomad_task_name                   | Name for the Task.                           | `"boundary_worker"` |
| nomad_task_resources              | Resource Limits for the Task.                | `{"cores":null,"cpu":500,"memory":512,"memory_max":1024}` |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

To use a controller-led activation flow](https://developer.hashicorp.com/boundary/docs/configuration/worker/pki-worker#controller-led-authorization-flow), Workers require access to a Controller-provided registration token.

The token may be generated via the Boundary CLI, or via an API client such as Terraform.

### Using the Boundary CLI

To generate a token with the Boundary CLI, the following commands may be used.

```shell
# set environment variables
export BOUNDARY_ADDR="https://<HCP Boundary Cluster ID>.boundary.hashicorp.cloud"
export BOUNDARY_AUTH_METHOD_ID="<Boundary Auth Method ID>"

# authenticate to Boundary Controller
boundary authenticate \
  password -login-name="cluster-admin"

# generate Boundary Controller Token and format output
boundary \
  workers \
    create controller-led \
    -format json \
  | \
  jq \
    --raw-output ".item.controller_generated_activation_token"
```

Once generated, the token (and, if using HCP Boundary, a Cluster ID) must be made available to the executing environment via [Nomad Variables](https://developer.hashicorp.com/nomad/docs/concepts/variables).

To do this, create a file called `boundary_worker.nv.hcl` with the following content:

```hcl
items {
  hcp_boundary_cluster_id               = "<HCP Boundary Cluster ID>"
  controller_generated_activation_token = "<Controller Token as generated above>"
}
```

Then, submit the file to Nomad:

```shell
nomad \
  var \
    -in "hcl" \
    "nomad/jobs/boundary_worker" "@boundary_worker.nv.hcl"
```

### Resource Sizing

For hardware sizing of the underlying Nomad Agents that are designed to run the Boundary Worker in this Nomad Pack, see the [HCP Boundary Self-managed Worker sizing guidelines](https://developer.hashicorp.com/hcp/docs/boundary/self-managed-workers/size-self-managed-workers#sizing-guidelines-for-self-managed-workers).

## Author Information

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
