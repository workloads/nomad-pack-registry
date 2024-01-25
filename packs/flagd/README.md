# Nomad Pack: OpenFeature flagd

![Nomad Pack: OpenFeature flagd](https://assets.workloads.io/nomad-pack-registry/flagd.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: OpenFeature flagd](#nomad-pack-openfeature-flagd)
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

The `flagd` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/flagd
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run flagd --registry=workloads
```

<!-- BEGIN_PACK_DOCS -->

### Application

This section describes Application-specific configuration.

| Name | Description | Default |
| -- | - | ------- |

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                                   | Default |
| --------------------------------- | ------------------------------------------------------------- | ------- |
| nomad_group_count                 | Count of Deployments for the Group.                           | `1` |
| nomad_group_ephemeral_disk        | Ephemeral Disk Configuration for the Group.                   | `{"migrate":false,"size":128,"sticky":false}` |
| nomad_group_name                  | Name for the Group.                                           | `"flagd"` |
| nomad_group_network_mode          | Network Mode for the Group.                                   | `"host"` |
| nomad_group_ports                 | Port and Healthcheck Configuration for the Group.             | `{"health":{"check_interval":"30s","check_timeout":"15s","host_network":null,"method":"GET","name":"health","omit_check":false,"path":"/healthz","port":8014,"type":"http"},"main":{"check_interval":"30s","check_timeout":"15s","host_network":null,"method":"POST","name":"main","omit_check":true,"path":"/","port":8013,"type":"http"}}` |
| nomad_group_restart_logic         | Restart Logic for the Group.                                  | `{"attempts":3,"delay":"30s","interval":"120s","mode":"fail"}` |
| nomad_group_service_name_prefix   | Name of the Service for the Group.                            | `"flagd"` |
| nomad_group_service_provider      | Provider of the Service for the Group.                        | `"nomad"` |
| nomad_group_tags                  | List of Tags for the Group.                                   | `["flagd"]` |
| nomad_group_volumes               | Volumes for the Group.                                        | `{}` |
| nomad_job_datacenters             | Eligible Datacenters for the Job.                             | `["*"]` |
| nomad_job_name                    | Name for the Job.                                             | `"flagd"` |
| nomad_job_namespace               | Namespace for the Job.                                        | `"default"` |
| nomad_job_priority                | Priority for the Job.                                         | `10` |
| nomad_job_region                  | Region for the Job.                                           | `"global"` |
| nomad_pack_verbose_output         | Toggle to enable verbose output.                              | `true` |
| nomad_task_args                   | Arguments to pass to the Task.                                | n/a |
| nomad_task_command                | Command to pass to the Task.                                  | `"start"` |
| nomad_task_driver                 | Driver to use for the Task.                                   | `"docker"` |
| nomad_task_image                  | Content Address to use for the Container Image for the Task.  | `{"digest":"sha256:bc771a0e42089111784f06168238304212c9f22c9b472934de5d4bd742a09a81","image":"flagd","namespace":"open-feature","registry":"ghcr.io","tag":"v0.6.7"}` |
| nomad_task_name                   | Name for the Task.                                            | `"flagd"` |
| nomad_task_resources              | Resource Limits for the Task.                                 | `{"cores":null,"cpu":500,"memory":64,"memory_max":512}` |
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

* flagd requires a feature flag definition to complete start-up.
  This value is provided via the Nomad Variable `flags`, which is stored at `nomad/jobs/flagd`.

* For testing purposes, a sample feature flag definition may be inserted like so:

```shell
nomad \
  var \
    put \
      -force \
      "nomad/jobs/flagd" \
      "flags=$(curl https://raw.githubusercontent.com/open-feature/flagd/main/samples/example_flags.flagd.json)"
```

The above example will force-write the content of [example_flags.flagd.json](https://raw.githubusercontent.com/open-feature/flagd/main/samples/example_flags.flagd.json) to the Nomad Variable `flags`, which is accessible to a Nomad Job named `flagd`.

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
