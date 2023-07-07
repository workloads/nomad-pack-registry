# Nomad Pack: RCON Web

![Nomad Pack: RCON Web](https://assets.workloads.io/nomad-pack-registry/rcon_web.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: RCON Web](#nomad-pack-rcon-web)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
      * [Application](#application)
      * [Nomad](#nomad)
    * [Outputs](#outputs)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.5.0` or newer
- HashiCorp nomad-pack `0.0.1` or newer
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
### Inputs

This Nomad Pack exposes configuration options via application- and Nomad-specific variables.

#### Application

This section describes application-specific configuration.

| Name | Description | Default |
| ---- | ----------- | ------- |
| `app_rwa_admin` | Toggle to set Initial User as Admin. | `true` |
| `app_rwa_env` | Toggle to allow configuration through Environment Variables. | `true` |
| `app_rwa_game` | Initial Game-Type. | `minecraft` |
| `app_rwa_password` | Initial User Password. | `AW96B6` |
| `app_rwa_rcon_host` | RCON Target Server Host. | `172.17.0.2` |
| `app_rwa_rcon_password` | RCON Target Server Password. | `AW96B6` |
| `app_rwa_rcon_port` | RCON Target Server Port. | `25575` |
| `app_rwa_read_only_widget_options` | Toggle to prevent Initial User from changing Widget Options. | `false` |
| `app_rwa_restrict_commands` | Restricted Commands for Initial User. | `ban,deop,stop` |
| `app_rwa_restrict_widgets` | Hidden Widgets for Initial User. | `` |
| `app_rwa_server_name` | Name of Target Server. | `minecraft` |
| `app_rwa_username` | Initial User Username. | `admin` |
| `app_rwa_web_rcon` | Toggle to enable Web RCON on Target Server. | `false` |

#### Nomad

This section describes Nomad and Nomad Pack-specific configuration.

| Name | Description | Default |
| ---- | ----------- | ------- |
| `nomad_group_count` | Count of Deployments for the Group. | `1` |
| `nomad_group_ephemeral_disk` | Ephemeral Disk Configuration for the Group. | `map[migrate:true size:128 sticky:false]` |
| `nomad_group_name` | Name for the Group. | `rcon` |
| `nomad_group_network_mode` | Network Mode for the Group. | `host` |
| `nomad_group_ports` | Port Configuration for the Group. | `map[main:map[check_interval:30s check_timeout:15s host_network:<nil> name:rcon_web_main path:/ port:4326 type:http] websocket:map[check_interval:30s check_timeout:15s host_network:<nil> name:rcon_web_websocket path:<nil> port:4327 type:tcp]]` |
| `nomad_group_restart_logic` | Restart Logic for the Group. | `map[attempts:3 delay:30s interval:120s mode:fail]` |
| `nomad_group_service_name_prefix` | Name of the Service for the Group. | `rcon_web` |
| `nomad_group_service_provider` | Provider of the Service for the Group. | `nomad` |
| `nomad_group_tags` | List of Tags for the Group. | `[rcon]` |
| `nomad_group_volumes` | Volumes for the Group. | `map[]` |
| `nomad_job_datacenters` | Eligible Datacenters for the Job. | `[*]` |
| `nomad_job_name` | Name for the Job. | `rcon_web` |
| `nomad_job_namespace` | Namespace for the Job. | `default` |
| `nomad_job_priority` | Priority for the Job. | `50` |
| `nomad_job_region` | Region for the Job. | `global` |
| `nomad_pack_verbose_output` | Toggle to enable verbose output. | `true` |
| `nomad_task_driver` | Driver to use for the Task. | `docker` |
| `nomad_task_image` | Content Address to use for the Container Image for the Task. | `map[digest:sha256:a9fc0b4116a7034c4849a4160d139a589bbf9211df64b48cc404e74c3e7bb730 image:rcon namespace:itzg registry:index.docker.io tag:latest]` |
| `nomad_task_name` | Name for the Task. | `rcon_web` |
| `nomad_task_resources` | Resource Limits for the Task. | `map[cores:<nil> cpu:500 memory:512 memory_max:1024]` |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
