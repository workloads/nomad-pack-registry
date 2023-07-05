# Nomad Pack: RCON Web

![Nomad Pack: RCON Web](https://assets.workloads.io/nomad-pack-registry/rcon_web.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: RCON Web](#nomad-pack-rcon-web)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
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

> **Note**
>
> For a more detailed description on how to use Nomad Pack, see [this guide](https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-intro#basic-use).

<!-- BEGIN_PACK_DOCS -->
### Inputs

| Name | Description | Type |
|------|-------------|------|
| app_rwa_admin | Toggle to set Initial User as Admin. | `bool` |
| app_rwa_env | Toggle to allow configuration through Environment Variables. | `bool` |
| app_rwa_game | Initial Game-Type. | `string` |
| app_rwa_password | Initial User Password. | `string` |
| app_rwa_rcon_host | RCON Target Server Host. | `string` |
| app_rwa_rcon_password | RCON Target Server Password. | `string` |
| app_rwa_rcon_port | RCON Target Server Port. | `number` |
| app_rwa_read_only_widget_options | Toggle to prevent Initial User from changing Widget Options. | `bool` |
| app_rwa_restrict_commands | Restricted Commands for Initial User. | `string` |
| app_rwa_restrict_widgets | Hidden Widgets for Initial User. | `string` |
| app_rwa_server_name | Name of Target Server. | `string` |
| app_rwa_username | Initial User Username. | `string` |
| app_rwa_web_rcon | Toggle to enable Web RCON on Target Server. | `bool` |
| count | Count of Deployments for the Job. | `number` |
| datacenters | Eligible Datacenters for the Task. | `list(string)` |
| driver | Driver to use for the Job. | `string` |
| ephemeral_disk | Ephemeral Disk Configuration for the Application. | <pre>object({<br>    migrate = bool<br>    size    = number<br>    sticky  = bool<br>  })</pre> |
| group_name | Name for the Group. | `string` |
| image | Content Address to use for the Container Image. | <pre>object({<br>    registry  = string<br>    namespace = string<br>    image     = string<br>    tag       = string<br>    digest    = string<br>  })</pre> |
| job_name | Name for the Job. | `string` |
| job_tags | List of Tags for the Job. | `list(string)` |
| namespace | Namespace for the Job. | `string` |
| network_mode | Network Mode for the Job. | `string` |
| ports | Port Configuration for the Application. | <pre>map(object({<br>    name           = string<br>    path           = string<br>    port           = number<br>    type           = string<br>    host_network   = string<br>    check_interval = string<br>    check_timeout  = string<br>  }))</pre> |
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

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
