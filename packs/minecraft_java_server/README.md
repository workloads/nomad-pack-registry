# Nomad Pack: Minecraft (Java Edition)

![Nomad Pack: Minecraft (Java Edition)](https://assets.workloads.io/nomad-pack-registry/minecraft_java_server.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Minecraft (Java Edition)](#nomad-pack-minecraft-java-edition)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.5.x` or newer
- HashiCorp nomad-pack `0.0.1` or newer
- Nomad Task Driver(s) for either [`docker`](https://developer.hashicorp.com/nomad/docs/drivers/docker) or [`podman`](https://developer.hashicorp.com/nomad/plugins/drivers/podman)

## Usage

The `minecraft_java_server` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/minecraft_java_server
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run minecraft_java_server --registry=workloads
```

> **Note**
>
> For a more detailed description on how to use Nomad Pack, see [this guide](https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-intro#basic-use).

<!-- BEGIN_PACK_DOCS -->
### Inputs

| Name | Description | Type |
|------|-------------|------|
| config | Application configuration. | <pre>object({<br>    allow_flight                 = bool<br>    allow_nether                 = bool<br>    announce_player_achievements = bool<br>    console                      = bool<br>    data                         = string<br>    difficulty                   = string<br>    disable_healthcheck          = bool<br>    enable_command_block         = bool<br>    enable_query                 = bool<br>    enable_rcon                  = bool<br>    enable_rolling_logs          = bool<br>    eula                         = bool<br>    generate_structures          = bool<br>    gui                          = bool<br>    hardcore                     = bool<br>    icon                         = string<br>    level_type                   = string<br>    max_build_height             = number<br>    max_players                  = number<br>    max_tick_time                = number<br>    max_world_size               = number<br>    memory                       = string<br>    mode                         = string<br>    mods_file                    = string<br>    motd                         = string<br>    online_mode                  = bool<br>    override_icon                = bool<br>    pvp                          = bool<br>    rcon_password                = string<br>    remove_old_mods              = bool<br>    seed                         = string<br>    server_name                  = string<br>    snooper_enabled              = bool<br>    spawn_animals                = bool<br>    spawn_monsters               = bool<br>    spawn_npcs                   = bool<br>    spawn_protection             = number<br>    tz                           = string<br>    type                         = string<br>    use_aikar_flags              = bool<br>    version                      = string<br>    view_distance                = number<br>    world                        = string<br>  })</pre> |
| consul_service_name | Consul Service Name for the Application. | `string` |
| consul_service_tags | Consul Service Tags for the Application. | `list(string)` |
| count | Number of desired Job Deployments. | `number` |
| datacenters | Datacenters that are eligible for Task Placement. | `list(string)` |
| driver | Driver to use for the Job. | `string` |
| ephemeral_disk | Ephemeral Disk configuration for the Application. | <pre>object({<br>    migrate = bool<br>    size    = number<br>    sticky  = bool<br>  })</pre> |
| image | Content Address to use for the Container Image. | <pre>object({<br>    registry  = string<br>    namespace = string<br>    image     = string<br>    tag       = string<br>    digest    = string<br>  })</pre> |
| job_name | Name of the Job. | `string` |
| job_tags | List of Tags for the Job. | `list(string)` |
| namespace | Namespace in which the Job should be placed. | `string` |
| network_mode | Network Mode for the Job. | `string` |
| ports | Port Configuration for the Application. | <pre>map(object({<br>    name = string,<br>    path = string,<br>    port = number,<br>    type = string,<br>  }))</pre> |
| priority | Priority of the Job. | `number` |
| region | Regions that are eligible for Job Deployment. | `string` |
| register_consul_service | Toggle to enable Consul Service Registration for the Job. | `bool` |
| resources | Resources to assign to the Application. | <pre>object({<br>    cpu    = number<br>    memory = number<br>  })</pre> |
| service_provider | Service Provider to use for the Application. | `string` |
| verbose_output | Toggle to enable verbose output. | `bool` |
| volumes | Mounts Configuration for the Application. | <pre>map(object({<br>    name        = string<br>    type        = string<br>    destination = string<br>    read_only   = bool<br>  }))</pre> |
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
