# Nomad Pack Registry

> This directory manages Nomad Packs for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Nomad Pack Registry](#nomad-pack-registry)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
  * [Adding the Nomad Pack Registry](#adding-the-nomad-pack-registry)
  * [Running a Nomad Pack](#running-a-nomad-pack)
    * [Testing a Nomad Pack](#testing-a-nomad-pack)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.5.5` or [newer](https://developer.hashicorp.com/nomad/downloads)
- HashiCorp Nomad Pack `0.0.1` or [newer](https://releases.hashicorp.com/nomad-pack/)
- a check-out of [@workloads/tooling](https://github.com/workloads/tooling)
- `terraform-docs` `0.16.0` or [newer](https://terraform-docs.io/user-guide/installation/)
- `newman` `5.3.2` or [newer](https://learning.postman.com/docs/collections/using-newman-cli/installing-running-newman/)

## Usage

This repository provides a workflow that is wrapped through a [Makefile](./Makefile).

Running `make` without commands will print out the following help information:

```text

🟢 NOMAD PACKS

Target          Description                                   Usage
env             create Nomad environment for testing          `make env pack=my_pack`
render          render a Nomad Pack                           `make render pack=my_pack`
run             run a Nomad Pack                              `make run pack=my_pack`
rerun           destroy and run a Nomad Pack                  `make rerun pack=my_pack`
stop            stop a running Nomad Pack                     `make stop pack=my_pack`
test            test a running Nomad Pack                     `make test pack=my_pack`
docs            generate documentation for all Nomad Packs    `make docs`
help            display a list of Make Targets                `make help`
registry        add Nomad Pack Registry to local environment  `make registry`
_listincludes   list all included Makefiles and *.mk files    `make _listincludes`
_selfcheck      lint Makefile                                 `make _selfcheck`
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
make run pack=my_pack
````

### Testing a Nomad Pack

The Nomad Packs in this Registry provide a test harness that may be used to verify the functionality of the Pack.

The harness is exposed through the `make env` and `make test` targets:

- `make env` starts a Nomad environment, using the configuration stored inside the Pack's `./tests/config.hcl` file.
- `make test` runs a [Postman Collection](https://learning.postman.com/docs/collections/collections-overview/), using the requests stored inside the Pack's `./tests/newman.json` file.

## Notes

* Colorized CLI output may be disabled by setting the `NO_COLOR` environment variable to any non-empty value.

```shell
export NO_COLOR=1 && make
```

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
