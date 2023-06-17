# Nomad Pack: Minecraft (Java Edition)

![Nomad Pack: Minecraft (Java Edition)](https://assets.workloads.io/nomad-pack-registry/minecraft_java_edition.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Minecraft (Java Edition)](#nomad-pack-minecraft-java-edition)
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

- HashiCorp Nomad `1.5.x` or newer
- HashiCorp nomad-pack `0.0.1` or newer
- Nomad Task Driver(s) for either [`docker`](https://developer.hashicorp.com/nomad/docs/drivers/docker) or [`podman`](https://developer.hashicorp.com/nomad/plugins/drivers/podman)

## Usage

The `minecraft_java_edition` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/minecraft_java_edition
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run minecraft_java_edition --registry=workloads
```

> **Note**
>
> For a more detailed description on how to use Nomad Pack, see [this guide](https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-intro#basic-use).

<!-- BEGIN_PACK_DOCS -->
### Inputs

| Name | Description | Type |
|------|-------------|------|
| app_allow_flight | Toggle to enable PC flight. | `bool` |
| app_allow_nether | Toggle to enable The Nether. | `bool` |
| app_announce_player_achievements | Toggle to enable Player Achievement Announcements. | `bool` |
| app_console | Toggle to enable Console. | `bool` |
| app_data | Directory for Application Data. | `string` |
| app_difficulty | Difficulty Level (e.g.: `peaceful`, `easy`, `normal`, `hard`). | `string` |
| app_disable_healthcheck | Toggle to disable Container Health Check. | `bool` |
| app_enable_command_block | Toggle to enable Command Blocks. | `bool` |
| app_enable_query | Toggle to enable Gamespy Query Protocol. | `bool` |
| app_enable_rcon | Toggle to enable RCON interface. | `bool` |
| app_enable_rolling_logs | Toggle to enable Log Rolling. | `bool` |
| app_eula | Toggle to accept End-User License Agreement. | `bool` |
| app_generate_structures | Toggle to pre-generate Structures (e.g.: Villages, Outposts). | `bool` |
| app_gui | Toggle to enable GUI. | `bool` |
| app_hardcore | Toggle to enable Hardcore Mode. | `bool` |
| app_icon | Server Icon. | `string` |
| app_level_type | Level Type (e.g.: `normal`, `flat`). | `string` |
| app_max_build_height | Maximum allowed Building Height (in blocks). | `number` |
| app_max_memory | Maximum allowed Memory. | `string` |
| app_max_players | Maximum Player Count. | `number` |
| app_max_tick_time | Maximum time a Tick may take before Watchdog responds (in msec). | `number` |
| app_max_world_size | Maximum Radius of World (in blocks). | `number` |
| app_memory | Initial Memory. | `string` |
| app_mode | Game Mode. | `string` |
| app_mods_file | Path to file with Mod URLs (e.g.: `/extras/mods.txt`) | `string` |
| app_motd | Message of the Day. | `string` |
| app_online_mode | Toggle to enable Account Authentication (with Minecraft.net / Microsoft Account). | `bool` |
| app_override_icon | Toggle to allow overriding Server Icon. | `bool` |
| app_pvp | Toggle to enable PvP Damage. | `bool` |
| app_rcon_password | RCON Interface Password. | `string` |
| app_remove_old_mods | Toggle to enable removal of old Mods. | `bool` |
| app_seed | Level Seed. | `string` |
| app_server_name | Server Name. | `string` |
| app_snooper_enabled | Toggle to enable sending updates to `snoop.minecraft.net`. | `bool` |
| app_spawn_animals | Toggle to enable Animals to spawn. | `bool` |
| app_spawn_monsters | Toggle to enable Monsters to spawn. | `bool` |
| app_spawn_npcs | Toggle to enable NPCs to spawn. | `bool` |
| app_spawn_protection | Sets area that non-ops cannot alter (in blocks). | `number` |
| app_type | Server Type (e.g.: `vanilla`, `fabric`, etc.). | `string` |
| app_tz | Timezone. | `string` |
| app_use_aikar_flags | Toggle to enable optimized JVM flags for GC tuning. | `bool` |
| app_version | Minecraft Version. | `string` |
| app_view_distance | Amount of World Data to send to define viewing distance (in blocks). | `number` |
| app_world | URL to Minecraft World ZIP archive. | `string` |
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
| ports | Port Configuration for the Application. | <pre>map(object({<br>    name           = string,<br>    path           = string,<br>    port           = number,<br>    type           = string,<br>    host_network   = string,<br>    check_interval = string,<br>    check_timeout  = string,<br>  }))</pre> |
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

## Notes

- By default, this Pack deploys a Minecraft server with persistent storage. This requires three [Nomad Volumes](https://developer.hashicorp.com/nomad/docs/job-specification/volume) to be configured. See the [test configuration](./tests/nomad.hcl) for an example.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
