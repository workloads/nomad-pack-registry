# Nomad Pack: Minecraft (Bedrock Edition)

![Nomad Pack: Minecraft (Bedrock Edition)](https://assets.workloads.io/nomad-pack-registry/minecraft_bedrock_edition.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Minecraft (Bedrock Edition)](#nomad-pack-minecraft-bedrock-edition)
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

- HashiCorp Nomad `1.5.0` or newer
- HashiCorp nomad-pack `0.0.1` or newer
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
### Inputs

| Name | Description | Type |
|------|-------------|------|
| app_allow_cheats | Toggle to enable Commands and Cheats. | `bool` |
| app_allow_list | Toggle to enable Allow-List (as stored in `allowlist.json`). | `bool` |
| app_compression_threshold | Size of raw Network Payload to compress. | `number` |
| app_content_log_file_enabled | Toggle to disable file-based Logging. | `bool` |
| app_correct_player_movement | Toggle to enable server-side Movement Validation. | `bool` |
| app_default_player_permission_level | Default Permission for new Players. | `string` |
| app_difficulty | Difficulty Level. | `string` |
| app_eula | Toggle to accept End-User License Agreement. | `bool` |
| app_force_gamemode | Toggle to force Players to always join in the default Game Mode. | `bool` |
| app_gamemode | Game Mode. | `string` |
| app_level_name | Name of Level to load. | `string` |
| app_level_seed | Level Seed | `string` |
| app_level_type | Level Type. | `string` |
| app_max_players | Maximum allowed Player Count. | `number` |
| app_max_threads | Maximum amount of Threads to use. | `number` |
| app_online_mode | Toggle to enable Account Authentication (with Minecraft.net / Microsoft Account). | `bool` |
| app_player_idle_timeout | Idle Timeout (in minutes) after which a Player is kicked. | `number` |
| app_player_movement_distance_threshold | Minimum Distance (in blocks) a Player must move before their Movement is validated. | `number` |
| app_player_movement_duration_threshold_in_ms | Minimum Duration (in msec) a Player must move before their Movement is validated. | `number` |
| app_player_movement_score_threshold | Number of incongruent Movements before a Player is kicked. | `number` |
| app_server_authoritative_block_breaking | Toggle to enable Server-Side Block Breaking Validation. | `bool` |
| app_server_authoritative_movement | Toggle to enable Server-Authoritative Movement Validation. | `string` |
| app_server_name | Name of the Server. | `string` |
| app_texturepack_required | Toggle to enable Texture Pack Requirement | `bool` |
| app_tick_distance | Maximum allowed Tick Distance (in chunks). | `number` |
| app_version | Minecraft Version. | `string` |
| app_view_distance | Maximum allowed View Distance (in chunks). | `number` |
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
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

- By default, this Pack deploys a Minecraft server with persistent storage. This requires one [Nomad Volume](https://developer.hashicorp.com/nomad/docs/job-specification/volume) to be configured. See the [test configuration](./tests/nomad_config.hcl) for an example.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
