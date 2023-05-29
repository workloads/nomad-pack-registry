# Nomad Pack Registry

> This directory manages Nomad Packs for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Nomad Pack Registry](#nomad-pack-registry)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* HashiCorp Nomad `1.5.5` or [newer](https://developer.hashicorp.com/nomad/downloads).
* HashiCorp Nomad Pack `0.0.1` or [newer](https://releases.hashicorp.com/nomad-pack/).
* `terraform-docs` `0.16.0` or [newer](https://terraform-docs.io/user-guide/installation/).

## Usage

This repository provides a workflow that is wrapped through a [Makefile](./Makefile).

Running `make` without commands will print out the following help information:

```text
NOMAD PACKS MAINTENANCE

render          render a Nomad Pack                           `make render pack="my_pack"`
run             run a Nomad Pack                              `make run pack="my_pack"`
rerun           destroy and run a Nomad Pack                  `make rerun pack="my_pack"`
stop            stop a running Nomad Pack                     `make stop pack="my_pack"`
test            create environment to test a Nomad Pack       `make test pack="my_pack"`
docs            generate documentation for all Nomad Packs    `make docs`
help            display a list of Make Targets                `make help`
_listincludes   list all included Makefiles and *.mk files    `make _listincludes`
_selfcheck      lint Makefile                                 `make _selfcheck`
```

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
