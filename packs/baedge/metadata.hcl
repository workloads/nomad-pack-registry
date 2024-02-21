app {
  url = "https://github.com/workloads/baedge-server"
}

pack {
  name        = "baedge"
  description = "A Nomad Pack for {Ba,E}dge"
  url         = "https://github.com/workloads/nomad-pack-registry/tree/main/packs/baedge"
  version     = "0.1.0"
}

# see https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-writing-packs#dependency
dependency "utilities" {
  # TODO: update to use the registry
  #source = "../utilities"
  source = "/Users/ksatirli/Desktop/workloads/nomad-pack-registry/packs/utilities"
}
