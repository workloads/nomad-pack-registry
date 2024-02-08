# Nomad Pack: Baedge

![Nomad Pack: Baedge](https://assets.workloads.io/nomad-pack-registry/baedge.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Baedge](#nomad-pack-baedge)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Application](#application)
    * [Nomad](#nomad)
    * [Utilities](#utilities)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Nomad Task Driver(s) for [`raw_exec`](https://developer.hashicorp.com/nomad/docs/drivers/raw_exec)

## Usage

The `baedge` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry).

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./packs/baedge
```

A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run baedge --registry=workloads
```

<!-- BEGIN_PACK_DOCS -->
<!-- END_PACK_DOCS -->

### Outputs

For outputs, see [./outputs.tpl](./outputs.tpl).

> **Note**
>
> The outputs are only rendered if `nomad_pack_verbose_output` is set to `true`.

## Notes

n/a

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/nomad-pack-registry/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
