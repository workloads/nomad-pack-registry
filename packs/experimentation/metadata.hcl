app {
  url = "https://github.com/workloads/nomad-pack-registry"
}

pack {
  name        = "experimentation"
  description = "A Nomad Pack for Experimentation"
  url         = "https://github.com/workloads/nomad-pack-registry/tree/main/packs/hello_world"
  version     = "0.0.0"
}

## see https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-writing-packs#dependency
#dependency "utilities" {
#  # TODO: update to use the registry
#  #source = "../utilities"
#  source = "/Users/ksatirli/Desktop/workloads/nomad-pack-registry/packs/utilities"
#}
