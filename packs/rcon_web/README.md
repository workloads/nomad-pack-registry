# Nomad Pack: RCON Web

![Nomad Pack: RCON Web](https://assets.workloads.io/nomad-pack-registry/rcon_web.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: RCON Web](#nomad-pack-rcon-web)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Application](#application)
    * [Nomad](#nomad)
    * [Outputs](#outputs)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Nomad Task Driver(s) for [`docker`](https://developer.hashicorp.com/nomad/docs/drivers/docker) or [`podman`](https://developer.hashicorp.com/nomad/plugins/drivers/podman)

## Usage

The `rcon_web` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/rcon_web
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run rcon_web --registry=workloads
```

<!-- BEGIN_PACK_DOCS -->

### Application

This section describes Application-specific configuration.

| Name                               | Description                                                   | Default |
| ---------------------------------- | ------------------------------------------------------------- | ------- |
| app_rwa_admin                      | Toggle to set Initial User as Admin.                          | `true` |
| app_rwa_env                        | Toggle to allow configuration through Environment Variables.  | `true` |
| app_rwa_game                       | Initial Game-Type.                                            | `"minecraft"` |
| app_rwa_password                   | Initial User Password.                                        | `"AW96B6"` |
| app_rwa_rcon_host                  | RCON Target Server Host.                                      | `"172.17.0.2"` |
| app_rwa_rcon_password              | RCON Target Server Password.                                  | `"AW96B6"` |
| app_rwa_rcon_port                  | RCON Target Server Port.                                      | `25575` |
| app_rwa_read_only_widget_options   | Toggle to prevent Initial User from changing Widget Options.  | `false` |
| app_rwa_restrict_commands          | Restricted Commands for Initial User.                         | `"ban,deop,stop"` |
| app_rwa_restrict_widgets           | Hidden Widgets for Initial User.                              | n/a |
| app_rwa_server_name                | Name of Target Server.                                        | `"minecraft"` |
| app_rwa_username                   | Initial User Username.                                        | `"admin"` |
| app_rwa_web_rcon                   | Toggle to enable Web RCON on Target Server.                   | `false` |

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                                   | Default |
| --------------------------------- | ------------------------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.                           | `1` |
| nomad_group_ephemeral_disk        | Ephemeral Disk Configuration for the Group.                   | `{"migrate":true,"size":128,"sticky":false}` |
| nomad_group_name                  | Name for the Group.                                           | `"rcon"` |
| nomad_group_network_mode          | Network Mode for the Group.                                   | `"host"` |
| nomad_group_ports                 | Port and Healthcheck Configuration for the Group.             | `{"main":{"check_interval":"30s","check_timeout":"15s","host_network":null,"name":"main","path":"/","port":4326,"type":"http"},"websocket":{"check_interval":"30s","check_timeout":"15s","host_network":null,"name":"websocket","path":null,"port":4327,"type":"tcp"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                                  | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.                            | `"rcon_web"` |
| nomad_group_service_provider      | Provider of the Service for the Group.                        | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                                   | `["rcon"]` |
| nomad_group_volumes               | Volumes for the Group.                                        | `{}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.                             | `["*"]` |
| nomad_job_name                    | Name for the Job.                                             | `"rcon_web"` |
| nomad_job_namespace               | Namespace for the Job.                                        | `"default"` |
| nomad_job_priority                | Priority for the Job.                                         | `50` |
| nomad_job_region                  | Region for the Job.                                           | `"global"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.                              | `true` |
| nomad_task_driver                 | Driver to use for the Task.                                   | `"docker"` |
| nomad_task_image                  | Content Address to use for the Container Image for the Task.  | `{"digest":"sha256:a9fc0b4116a7034c4849a4160d139a589bbf9211df64b48cc404e74c3e7bb730","image":"rcon","namespace":"itzg","registry":"index.docker.io","tag":"latest"}` |
| nomad_task_name                   | Name for the Task.                                            | `"rcon_web"` |
| nomad_task_resources              | Resource Limits for the Task.                                 | `{"cores":null,"cpu":500,"memory":512,"memory_max":1024}` |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
