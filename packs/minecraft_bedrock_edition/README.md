# Nomad Pack: Minecraft (Bedrock Edition)

![Nomad Pack: Minecraft (Bedrock Edition)](https://assets.workloads.io/nomad-pack-registry/minecraft_bedrock_edition.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Minecraft (Bedrock Edition)](#nomad-pack-minecraft-bedrock-edition)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Application](#application)
    * [Nomad](#nomad)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Nomad Task Driver(s) for [`docker`](https://developer.hashicorp.com/nomad/docs/drivers/docker) or [`podman`](https://developer.hashicorp.com/nomad/plugins/drivers/podman)

## Usage

The `minecraft_bedrock_edition` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/minecraft_bedrock_edition
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run minecraft_bedrock_edition --registry=workloads
```

<!-- BEGIN_PACK_DOCS -->

### Application

This section describes Application-specific configuration.

| Name                                           | Description                                                                          | Default |
| ---------------------------------------------- | ------------------------------------------------------------------------------------ | ------- |
| app_allow_cheats                               | Toggle to enable Commands and Cheats.                                                | `true` |
| app_allow_list                                 | Toggle to enable Allow-List (as stored in `allowlist.json`).                         | `false` |
| app_compression_threshold                      | Size of raw Network Payload to compress.                                             | `1` |
| app_content_log_file_enabled                   | Toggle to disable file-based Logging.                                                | `false` |
| app_correct_player_movement                    | Toggle to enable server-side Movement Validation.                                    | `false` |
| app_default_player_permission_level            | Default Permission for new Players.                                                  | `"member"` |
| app_difficulty                                 | Difficulty Level.                                                                    | `"peaceful"` |
| app_eula                                       | Toggle to accept End User License Agreement.                                         | `true` |
| app_force_gamemode                             | Toggle to force Players to always join in the default Game Mode.                     | `false` |
| app_gamemode                                   | Game Mode.                                                                           | `"creative"` |
| app_level_name                                 | Name of Level to load.                                                               | n/a |
| app_level_seed                                 | Level Seed                                                                           | `"-3420545464665791887"` |
| app_level_type                                 | Level Type.                                                                          | `"DEFAULT"` |
| app_max_players                                | Maximum allowed Player Count.                                                        | `10` |
| app_max_threads                                | Maximum amount of Threads to use.                                                    | n/a |
| app_online_mode                                | Toggle to enable Account Authentication (with Minecraft.net / Microsoft Account).    | `false` |
| app_op_permission_level                        | Sets the default Permission Level for new Ops.                                       | `2` |
| app_player_idle_timeout                        | Idle Timeout (in minutes) after which a Player is kicked.                            | `15` |
| app_player_movement_distance_threshold         | Minimum Distance (in blocks) a Player must move before their Movement is validated.  | `0.3` |
| app_player_movement_duration_threshold_in_ms   | Minimum Duration (in msec) a Player must move before their Movement is validated.    | `500` |
| app_player_movement_score_threshold            | Number of incongruent Movements before a Player is kicked.                           | `20` |
| app_server_authoritative_block_breaking        | Toggle to enable Server-Side Block Breaking Validation.                              | `false` |
| app_server_authoritative_movement              | Toggle to enable Server-Authoritative Movement Validation.                           | `"server-auth"` |
| app_server_name                                | Name of the Server.                                                                  | `"Minecraft Bedrock Edition Server"` |
| app_texturepack_required                       | Toggle to enable Texture Pack Requirement                                            | `false` |
| app_tick_distance                              | Maximum allowed Tick Distance (in chunks).                                           | `4` |
| app_version                                    | Minecraft Version.                                                                   | `"1.20.1.02"` |
| app_view_distance                              | Maximum allowed View Distance (in chunks).                                           | `32` |

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                                   | Default |
| --------------------------------- | ------------------------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.                           | `1` |
| nomad_group_ephemeral_disk        | Ephemeral Disk Configuration for the Group.                   | `{"migrate":true,"size":1024,"sticky":true}` |
| nomad_group_name                  | Name for the Group.                                           | `"minecraft"` |
| nomad_group_network_mode          | Network Mode for the Group.                                   | `"host"` |
| nomad_group_ports                 | Port Configuration for the Group.                             | `{"main":{"check_interval":"30s","check_timeout":"15s","host_network":null,"method":null,"omit_check":false,"path":null,"port":19132,"type":"tcp"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                                  | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.                            | `"minecraft"` |
| nomad_group_service_provider      | Provider of the Service for the Group.                        | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                                   | `["minecraft","minecraft-bedrock-edition"]` |
| nomad_group_volumes               | Volumes for the Group.                                        | `{"data":{"destination":"/data","name":"minecraft_bedrock_data","read_only":false,"type":"host"}}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.                             | `["*"]` |
| nomad_job_name                    | Name for the Job.                                             | `"minecraft"` |
| nomad_job_namespace               | Namespace for the Job.                                        | `"default"` |
| nomad_job_priority                | Priority for the Job.                                         | `99` |
| nomad_job_region                  | Region for the Job.                                           | `"global"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.                              | `true` |
| nomad_task_driver                 | Driver to use for the Task.                                   | `"docker"` |
| nomad_task_image                  | Content Address to use for the Container Image for the Task.  | `{"digest":"sha256:e2019e959daa70dffd1468aaa1348bc906170709bf2c790bee302fc1efedbde7","image":"minecraft-bedrock-server","namespace":"itzg","registry":"index.docker.io","tag":"2023.8.1"}` |
| nomad_task_name                   | Name for the Task.                                            | `"minecraft"` |
| nomad_task_resources              | Resource Limits for the Task.                                 | `{"cores":null,"cpu":4000,"memory":4096,"memory_max":5120}` |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

- By default, this Pack deploys a Minecraft server with persistent storage. This requires one [Nomad Volume](https://developer.hashicorp.com/nomad/docs/job-specification/volume) to be configured. See the [test configuration](./tests/nomad_config.hcl) for an example.

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
