app {
  url = "https://docs.datadoghq.com/agent/"

  # TODO: remove when next nomad-pack version is released
  author = "Datadog"
}

pack {
  name        = "datadog_agent"
  description = "A Nomad Pack for Datadog Agent"
  url         = "https://github.com/workloads/nomad-pack-registry/tree/main/packs/datadog_agent"
  version     = "1.0.0"
}
