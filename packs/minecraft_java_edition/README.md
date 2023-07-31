# Nomad Pack: Minecraft (Java Edition)

![Nomad Pack: Minecraft (Java Edition)](https://assets.workloads.io/nomad-pack-registry/minecraft_java_edition.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Minecraft (Java Edition)](#nomad-pack-minecraft-java-edition)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
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

<!-- BEGIN_PACK_DOCS -->

#### Application

This section describes Application-specific configuration.

| Name                               | Description                                                                        | Default |
| ---------------------------------- | ---------------------------------------------------------------------------------- | ------- |
| app_allow_flight                   | Toggle to enable PC flight.                                                        | `true` |
| app_allow_nether                   | Toggle to enable The Nether.                                                       | `false` |
| app_announce_player_achievements   | Toggle to enable Player Achievement Announcements.                                 | `false` |
| app_console                        | Toggle to enable Console.                                                          | `true` |
| app_data                           | Directory for Application Data.                                                    | `"/data"` |
| app_difficulty                     | Difficulty Level (e.g.: `peaceful`, `easy`, `normal`, `hard`).                     | `"peaceful"` |
| app_disable_healthcheck            | Toggle to disable Container Health Check.                                          | `false` |
| app_enable_command_block           | Toggle to enable Command Blocks.                                                   | `true` |
| app_enable_query                   | Toggle to enable Gamespy Query Protocol.                                           | `false` |
| app_enable_rcon                    | Toggle to enable RCON interface.                                                   | `true` |
| app_enable_rolling_logs            | Toggle to enable Log Rolling.                                                      | `true` |
| app_eula                           | Toggle to accept End-User License Agreement.                                       | `true` |
| app_generate_structures            | Toggle to pre-generate Structures (e.g.: Villages, Outposts).                      | `true` |
| app_gui                            | Toggle to enable GUI.                                                              | `true` |
| app_hardcore                       | Toggle to enable Hardcore Mode.                                                    | `false` |
| app_icon                           | Server Icon.                                                                       | `"https://assets.workloads.io/minecraft/server-icons/command-block.png"` |
| app_level_type                     | Level Type (e.g.: `normal`, `flat`).                                               | `"normal"` |
| app_max_build_height               | Maximum allowed Building Height (in blocks).                                       | `256` |
| app_max_memory                     | Maximum allowed Memory.                                                            | `"4G"` |
| app_max_players                    | Maximum Player Count.                                                              | `20` |
| app_max_tick_time                  | Maximum time a Tick may take before Watchdog responds (in msec).                   | `60000` |
| app_max_world_size                 | Maximum Radius of World (in blocks).                                               | `10000` |
| app_memory                         | Initial Memory.                                                                    | `"3G"` |
| app_mode                           | Game Mode.                                                                         | `"creative"` |
| app_mods_file                      | Path to file with Mod URLs (e.g.: `/extras/mods.txt`)                              | n/a |
| app_motd                           | Message of the Day.                                                                | `"This Server is running on §2§lHashiCorp Nomad§r!"` |
| app_online_mode                    | Toggle to enable Account Authentication (with Minecraft.net / Microsoft Account).  | `false` |
| app_override_icon                  | Toggle to allow overriding Server Icon.                                            | `true` |
| app_pvp                            | Toggle to enable PvP Damage.                                                       | `false` |
| app_rcon_password                  | RCON Interface Password.                                                           | `"AW96B6"` |
| app_remove_old_mods                | Toggle to enable removal of old Mods.                                              | `true` |
| app_seed                           | Level Seed.                                                                        | `"5379859465535818918"` |
| app_server_name                    | Server Name.                                                                       | `"Minecraft Java Edition Server"` |
| app_snooper_enabled                | Toggle to enable sending updates to `snoop.minecraft.net`.                         | `false` |
| app_spawn_animals                  | Toggle to enable Animals to spawn.                                                 | `true` |
| app_spawn_monsters                 | Toggle to enable Monsters to spawn.                                                | `false` |
| app_spawn_npcs                     | Toggle to enable NPCs to spawn.                                                    | `true` |
| app_spawn_protection               | Sets area that non-ops cannot alter (in blocks).                                   | n/a |
| app_type                           | Server Type (e.g.: `vanilla`, `fabric`, etc.).                                     | `"vanilla"` |
| app_tz                             | Timezone.                                                                          | `"Europe/Amsterdam"` |
| app_use_aikar_flags                | Toggle to enable optimized JVM flags for GC tuning.                                | `true` |
| app_version                        | Minecraft Version.                                                                 | `"1.20"` |
| app_view_distance                  | Amount of World Data to send to define viewing distance (in blocks).               | `32` |
| app_world                          | URL to Minecraft World ZIP archive.                                                | n/a |

#### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                                   | Default |
| --------------------------------- | ------------------------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.                           | `1` |
| nomad_group_ephemeral_disk        | Ephemeral Disk Configuration for the Group.                   | `{"migrate":true,"size":1024,"sticky":true}` |
| nomad_group_name                  | Name for the Group.                                           | `"minecraft"` |
| nomad_group_network_mode          | Network Mode for the Group.                                   | `"host"` |
| nomad_group_ports                 | Port Configuration for the Group.                             | `{"main":{"check_interval":"30s","check_timeout":"15s","host_network":null,"name":"minecraft_main","path":null,"port":25565,"type":"tcp"},"rcon":{"check_interval":"30s","check_timeout":"15s","host_network":null,"name":"minecraft_rcon","path":null,"port":25575,"type":"tcp"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                                  | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.                            | `"minecraft"` |
| nomad_group_service_provider      | Provider of the Service for the Group.                        | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                                   | `["minecraft","minecraft-java-edition"]` |
| nomad_group_volumes               | Volumes for the Group.                                        | `{"minecraft_data":{"destination":"/data","name":"minecraft_data","read_only":false,"type":"host"},"minecraft_extras":{"destination":"/extras","name":"minecraft_extras","read_only":false,"type":"host"},"minecraft_worlds":{"destination":"/worlds","name":"minecraft_worlds","read_only":false,"type":"host"}}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.                             | `["*"]` |
| nomad_job_name                    | Name for the Job.                                             | `"minecraft"` |
| nomad_job_namespace               | Namespace for the Job.                                        | `"default"` |
| nomad_job_priority                | Priority for the Job.                                         | `99` |
| nomad_job_region                  | Region for the Job.                                           | `"global"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.                              | `true` |
| nomad_task_driver                 | Driver to use for the Task.                                   | `"docker"` |
| nomad_task_image                  | Content Address to use for the Container Image for the Task.  | `{"digest":"sha256:722dde03948a7979681221b31b99d08608e082e8d76c9b65b5dbb20791278da6","image":"minecraft-server","namespace":"itzg","registry":"index.docker.io","tag":"2023.6.4-java20-alpine"}` |
| nomad_task_name                   | Name for the Task.                                            | `"minecraft"` |
| nomad_task_resources              | Resource Limits for the Task.                                 | `{"cores":null,"cpu":4000,"memory":4096,"memory_max":5120}` |

<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

- By default, this Pack deploys a Minecraft server with persistent storage. This requires three [Nomad Volumes](https://developer.hashicorp.com/nomad/docs/job-specification/volume) to be configured. See the [test configuration](./tests/nomad_config.hcl) for an example.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
