# Nomad Pack: Common Utilities

![Nomad Pack: Common Utilities](https://assets.workloads.io/nomad-pack-registry/utilities.png)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: Common Utilities](#nomad-pack-common-utilities)
  * [Table of Contents](#table-of-contents)
  * [Usage](#usage)
  * [License](#license)
<!-- TOC -->

## Usage

> [!NOTE]
> The `utilities` Pack is not designed to be run stand-alone.

The `utility` Pack is a collection of common utilities. These utilities are presented as [Template Helpers](https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-writing-packs#write-the-templates) and should be loaded as a _dependency_:

```hcl
# see https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-writing-packs#dependency
dependency "utilities" {
  source = "../utilities"
}
```

The included templates can be used like any other template:

```hcl
  [[ template "util_job_meta" . ]]
```

For an example of how to use the `utilities` Pack, see the [hello_world](../hello_world) Pack.

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
