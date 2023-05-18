# Nomad Pack Registry

> This directory manages Nomad Packs for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Nomad Pack Registry](#nomad-pack-registry)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
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

help       Displays a list of Make Targets          Usage: `make` or `make help`
render     Renders a Nomad Pack                     Usage: `make render pack=my-pack`
run        Runs a Nomad Pack                        Usage: `make run pack=my-pack`
rerun      Destroys and Runs a Nomad Pack           Usage: `make rerun pack=my-pack`
stop       Stops a (running) Nomad Pack             Usage: `make stop pack=my-pack`
docs       Generates Documentation for all Packs    Usage: `make docs`
selfcheck  Lints Makefile                           Usage: `make selfcheck`
```

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
