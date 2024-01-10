# Nomad Pack Registry

> This repository manages Nomad Packs for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Nomad Pack Registry](#nomad-pack-registry)
  * [Table of Contents](#table-of-contents)
  * [Available Packs](#available-packs)
  * [Requirements](#requirements)
    * [Development](#development)
  * [Usage](#usage)
  * [Adding the Nomad Pack Registry](#adding-the-nomad-pack-registry)
  * [Running a Nomad Pack](#running-a-nomad-pack)
    * [Testing a Nomad Pack](#testing-a-nomad-pack)
  * [Notes](#notes)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Available Packs

| Pack Name                                                        | Description                          | Task Driver(s)                       |
|------------------------------------------------------------------|--------------------------------------|--------------------------------------|
| [`boundary_worker`](./packs/boundary_worker)                     | HCP Boundary Workers                 | `exec`[^exec], `raw_exec`[^raw_exec] |
| [`datadog_agent`](./packs/datadog_agent)                         | Datadog Agents                       | `raw_exec`[^raw_exec]                |
| [`flagd`](./packs/flagd)                                         | OpenFeature `flagd` (Docker, Podman) | `docker`[^docker], `podman`[^podman] |
| [`hello_world`](./packs/hello_world)                             | Nomad feature-testing                | `exec`[^exec], `raw_exec`[^raw_exec] |
| [`minecraft_bedrock_edition`](./packs/minecraft_bedrock_edition) | Minecraft (Bedrock Edition)          | `docker`[^docker], `podman`[^podman] |
| [`minecraft_java_edition`](./packs/minecraft_java_edition)       | Minecraft (Java Edition)             | `docker`[^docker], `podman`[^podman] |
| [`rcon_web`](./packs/rcon_web)                                   | RCON Web (for Minecraft etc.)        | `docker`[^docker], `podman`[^podman] |

## Requirements

* HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/downloads)
* HashiCorp Nomad Pack `0.1.x` or [newer](https://releases.hashicorp.com/nomad-pack/)
* a copy of [@workloads/tooling](https://github.com/workloads/tooling)

### Development

For development and testing of this repository:

* `terraform-docs` `0.17.0` or [newer](https://terraform-docs.io/user-guide/installation/)
* `newman` `5.3.0` or [newer](https://learning.postman.com/docs/collections/using-newman-cli/installing-running-newman/)

## Usage

This repository provides a [Makefile](./Makefile)-based workflow.

Running `make` without commands will print out the following help information:

```text
env             create Nomad environment for testing            `make env pack=<pack>`
render          render a Nomad Pack                             `make render pack=<pack>`
run             run a Nomad Pack                                `make run pack=<pack>`
rerun           destroy and run a Nomad Pack                    `make rerun pack=<pack>`
stop            stop a running Nomad Pack                       `make stop pack=<pack>`
test            test a running Nomad Pack                       `make test pack=<pack>`
restart         restart a Task                                  `make restart task=<task>`
format          format HCL files for all Nomad Packs            `make format`
docs            generate documentation for all Nomad Packs      `make docs`
registry        add Nomad Pack Registry to local environment    `make registry`
help            display a list of Make Targets                  `make help`
_listincludes   list all included Makefiles and *.mk files      `make _listincludes`
_selfcheck      lint Makefile                                   `make _selfcheck`
```

## Adding the Nomad Pack Registry

This Nomad Pack Registry may be added to an environment like so:

```shell
make registry
````

For more information see [developer.hashicorp.com](https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-intro#adding-non-default-pack-registries).

## Running a Nomad Pack

Nomad Packs are stored in the [`./packs`](./packs) directory and feature detailed documentation and accompanying files.

A Nomad Pack may be run like so:

```shell
make run pack=<pack>
````

### Testing a Nomad Pack

The Nomad Packs in this Registry provide a test harness that may be used to verify the functionality of the Pack.

The harness is exposed through the `make env` and `make test` targets:

* `make env` starts a Nomad environment, using the configuration stored inside the Pack's `./tests/nomad_config.hcl` file.
* `make test` runs a [Postman Collection](https://learning.postman.com/docs/collections/collections-overview/), using the requests stored inside the Pack's `./tests/newman.json` file.

The `make env` command automatically creates any directories and variables that are set in `./tests/test.mk`.

Additionally, `./tests/gitignored_config.mk` may be used to set sensitive variables, such as API tokens, that should not be committed to version control.

## Notes

* Colorized CLI output may be disabled by setting the `NO_COLOR` environment variable to any non-empty value.

```shell
export NO_COLOR=1 && make
```

* For `nomad-pack` arguments that are not supported by the [Makefile](./Makefile), the `ARGS` variable may be used like so:

```shell
 make render pack=<pack> ARGS="--render-output-template"
```

* The binaries for `nomad` and `nomad-pack` may be overridden by setting the `BINARY_NOMAD` and `BINARY_NOMAD_PACK` arguments when running the [Makefile](./Makefile):

```shell
# override `nomad` binary
make render pack=<pack> BINARY_NOMAD=/tmp/nomad

# override `nomad-pack` binary
make render pack=<pack> BINARY_NOMAD_PACK=/tmp/nomad-pack
```

* The reporter for `newman` may be overridden by setting the `NEWMAN_REPORTERS` argument when running the [Makefile](./Makefile):

```shell
# override `newman` reporter
make render pack=<pack> NEWMAN_REPORTERS="progress"
```

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.

[^exec]: [`exec`](https://developer.hashicorp.com/nomad/docs/drivers/exec)
[^docker]: [`docker`](https://developer.hashicorp.com/nomad/docs/drivers/docker)
[^podman]: [`podman`](https://developer.hashicorp.com/nomad/docs/drivers/podman)
[^raw_exec]: [`raw_exec`](https://developer.hashicorp.com/nomad/docs/drivers/raw_exec)
