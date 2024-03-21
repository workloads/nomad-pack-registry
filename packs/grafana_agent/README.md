# Nomad Pack: Grafana Agent

![Nomad Pack: Grafana Agent](https://assets.workloads.io/nomad-pack-registry/grafana_agent.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Grafana Agent](#nomad-pack-grafana-agent)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Application](#application)
    * [Nomad](#nomad)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.5.0` or newer
- HashiCorp nomad-pack `0.0.1` or newer
- Nomad Task Driver(s) for [`docker`](https://developer.hashicorp.com/nomad/docs/drivers/docker) or [`podman`](https://developer.hashicorp.com/nomad/plugins/drivers/podman)

## Usage

This Pack deploys the [Grafana Agent](https://grafana.com/docs/agent/latest/) in [Flow mode](https://grafana.com/docs/agent/latest/flow/) which is the new, components-based OpenTelemetry distribution that is configured using a River configuration file.

Variables (described in detail below) can be passed using the `-var` flag, or by using a `.hcl` file with the `-var-file` flag. The only mandatory variable is `grafana_agent_configuration`, which should point to the location of the Grafana Agent configuration file on your system. 

Example Grafana Agent configuration files can be found in the [./config](./config) directory. 

The `grafana_agent` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/grafana_agent -var grafana_agent_configuration="./grafana-agent-vars.river"
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run grafana_agent --registry=workloads -var-file="overrides.hcl" 
```


<!-- BEGIN_PACK_DOCS -->

### Application

This section describes Application-specific configuration.

| Name | Description | Default |
| -- | - | ------- |
| grafana_agent_configuration | The path, relative or absolute, of the Grafana Agent configuration file on your system | No default, has to be specified. |

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                                   | Default |
| --------------------------------- | ------------------------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.                           | `1` |
| nomad_group_name                  | Name for the Group.                                           | `"grafana_agent"` |
| nomad_group_network_mode          | Network Mode for the Group.                                   | `"host"` |
| nomad_group_ports                 | Port Configuration for the Group.                             | `{"health":{"check_interval":"30s","check_timeout":"15s","host_network":null,"method":"GET","name":"health","omit_check":false,"path":"/healthz","port":8014,"type":"http"},"main":{"check_interval":"30s","check_timeout":"15s","host_network":null,"method":"POST","name":"main","omit_check":true,"path":"/","port":8013,"type":"http"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                                  | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.                            | `"grafana_agent"` |
| nomad_group_service_provider      | Provider of the Service for the Group.                        | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                                   | `["grafana_agent"]` |
| nomad_group_volumes               | Volumes for the Group.                                        | `{}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.                             | `["*"]` |
| nomad_job_name                    | Name for the Job.                                             | `"grafana_agent"` |
| nomad_job_namespace               | Namespace for the Job.                                        | `"default"` |
| nomad_job_type                    | Job type (service or system) the Job.                         | `"service"` |
| nomad_job_priority                | Priority for the Job.                                         | `10` |
| nomad_job_region                  | Region for the Job.                                           | `"global"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.                              | `true` |
| nomad_task_args                   | Arguments to pass to the Task.                                | n/a |
| nomad_task_driver                 | Driver to use for the Task.                                   | `"docker"` |
| nomad_task_image                  | Content Address to use for the Container Image for the Task.  | `{"digest":"sha256:fb248f9c5de9354e39d63fc3a5a8bde508cead41ecc3492f0e9d6a3d315d50b3","image":"agent","namespace":"grafana","registry":"docker.io","tag":"v0.38.1"}` |
| nomad_task_name                   | Name for the Task.                                            | `"grafana_agent"` |
| nomad_task_resources              | Resource Limits for the Task.                                 | `{"cores":null,"cpu":500,"memory":128,"memory_max":512}` |

<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

* The Grafana Agent requires a configuration file in the River format locally on your system, in the path referenced by the variable `grafana_agent_configuration`. You can find a small example one that scrapes a Prometheus target and pushes to a remote Prometheus server in [./config/grafana-agent.river]. You can use Grafana's [Agent Configuration](https://grafana.github.io/agent-configurator/) to build a configuration file, or follow their [docs](https://grafana.com/docs/agent/latest/flow/reference/components/).

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
