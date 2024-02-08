app {
  url = "https://github.com/workloads/nomad-pack-registry"
}

pack {
  name        = "baedge"
  description = "A Nomad Pack for Project {Ba,e}dge"
  url         = "https://github.com/workloads/nomad-pack-registry/tree/main/packs/baedge"
  version     = "0.0.0"
}

# see https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-writing-packs#dependency
dependency "utilities" {
  # TODO: update to use the registry
  #source = "../utilities"
  source = "/Users/ksatirli/Desktop/workloads/nomad-pack-registry/packs/utilities"
}
