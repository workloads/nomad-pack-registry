# Nomad Pack: Baedge

![Nomad Pack: Baedge](https://assets.workloads.io/nomad-pack-registry/baedge.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Baedge](#nomad-pack-baedge)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Application](#application)
    * [Nomad](#nomad)
    * [Utilities](#utilities)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Nomad Task Driver(s) for [`raw_exec`](https://developer.hashicorp.com/nomad/docs/drivers/raw_exec)

## Usage

The `baedge` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/baedge
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run baedge --registry=workloads
```

<!-- BEGIN_PACK_DOCS -->

### Application

This section describes Application-specific configuration.

| Name                        | Description                                            | Default |
| --------------------------- | ------------------------------------------------------ | ------- |
| app_application_directory   | Location of the application directory.                 | `"/Users/ksatirli/Desktop/workloads/baedge-server"` |
| app_application_file        | Name of the Application file.                          | `"server.py"` |
| app_binary_git              | Name (and optional Path) to the `git` binary to use.   | `"git"` |
| app_binary_pip              | Name (and optional Path) to the `pip` binary to use.   | `"pip"` |
| app_binary_python           | Name (and optional Path) to the Python binary to use.  | `"python"` |
| app_examples_directory      | Location of the examples directory.                    | `"/opt/e-Paper/RaspberryPi_JetsonNano/python/examples"` |

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                        | Default |
| --------------------------------- | -------------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.                | `1` |
| nomad_group_ephemeral_disk        | Ephemeral Disk Configuration for the Group.        | `{"migrate":true,"size":128,"sticky":false}` |
| nomad_group_name                  | Name for the Group.                                | `"baedge"` |
| nomad_group_network_mode          | Network Mode for the Group.                        | `"host"` |
| nomad_group_ports                 | Port and Healthcheck Configuration for the Group.  | `{"main":{"check_interval":"30s","check_timeout":"15s","host_network":null,"method":null,"omit_check":false,"path":"/v1/status","port":2343,"type":"tcp"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                       | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.                 | `"baedge"` |
| nomad_group_service_provider      | Provider of the Service for the Group.             | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                        | `["baedge"]` |
| nomad_group_volumes               | Volumes for the Group.                             | `{}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.                  | `["*"]` |
| nomad_job_name                    | Name for the Job.                                  | `"baedge"` |
| nomad_job_namespace               | Namespace for the Job.                             | `"default"` |
| nomad_job_priority                | Priority for the Job.                              | `10` |
| nomad_job_region                  | Region for the Job.                                | `"global"` |
| nomad_job_type                    | Specifies the Nomad scheduler to use.              | `"system"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.                   | `true` |
| nomad_task_driver                 | Driver to use for the Task.                        | `"raw_exec"` |
| nomad_task_name                   | Name for the Task.                                 | `"baedge"` |
| nomad_task_name_suffix            | Name Suffixes for the Tasks.                       | `{"client_heartbeat":"client-heartbeat","server":"server"}` |
| nomad_task_resources              | Resource Limits for the Task.                      | `{"cores":null,"cpu":1000,"memory":128,"memory_max":256}` |

### Utilities

This section describes Utilities-specific configuration.

| Name              | Description                                | Default |
| ----------------- | ------------------------------------------ | ------- |
| utility_actions   | Actions to enable via the Utilities Pack.  | `{"print_env":true,"print_nomad_env":true}` |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

n/a

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
