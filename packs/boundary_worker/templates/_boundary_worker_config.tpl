[[- define "boundary_worker_config" ]]
# see https://developer.hashicorp.com/boundary/docs/configuration#disable_mlock
disable_mlock = true

[[- if var "app_enable_hcp_boundary_support" . ]]
{{ with nomadVar "nomad/jobs/[[ var "nomad_job_name" . ]]" }}
# see https://developer.hashicorp.com/boundary/docs/configuration#hcp_boundary_cluster_id
hcp_boundary_cluster_id = "{{ .hcp_boundary_cluster_id }}"
{{- end }}
[[ else ]]
# see https://developer.hashicorp.com/boundary/docs/configuration/worker#initial_upstreams
initial_upstreams = [[ var "app_initial_upstreams" . ]]
[[- end ]]

[[- if var "nomad_group_ports.proxy" . ]]
# see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp
listener "tcp" {
  address = "{{ env "NOMAD_ADDR_proxy" }}"

  # see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp#purpose
  purpose = "proxy"

  # see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp#cors_allowed_origins
  cors_enabled = true

  cors_allowed_origins = [
    "*"
  ]
}
[[- end ]]

[[ if var "nomad_group_ports.ops" . ]]
# see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp
listener "tcp" {
  address = "{{ env "NOMAD_ADDR_ops" }}"

  # see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp#purpose
  purpose = "ops"

  # TODO: document
  # see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp#tls
  tls_disable = true
}
[[- end -]]

# see https://developer.hashicorp.com/boundary/docs/configuration/worker
worker {
  # see https://developer.hashicorp.com/boundary/tutorials/hcp-administration/hcp-manage-workers#auth_storage_path
  # TODO: change to `NOMAD_ALLOC_SECRETS_DIR` once available cross-task
  auth_storage_path = "{{ env "NOMAD_ALLOC_DIR" }}/auth"

  # see https://developer.hashicorp.com/boundary/docs/configuration/worker#public_addr
  public_addr = "{{ env "NOMAD_ADDR_proxy" }}"

  # see https://developer.hashicorp.com/boundary/docs/configuration/worker/pki-worker#controller-led-authorization-flow
  # TODO: change to `NOMAD_ALLOC_SECRETS_DIR` once available cross-task
  controller_generated_activation_token = "file:///{{ env "NOMAD_ALLOC_DIR" }}/worker_activation_token"

  # see https://developer.hashicorp.com/boundary/docs/configuration/worker#tags
  tags {
    # see https://developer.hashicorp.com/nomad/docs/runtime/interpolation#node-attributes
    nomad_client     = "{{ env "node.unique.name" | toLower }}"
    nomad_dc         = "{{ env "node.datacenter" | toLower }}"
    nomad_hostname   = "{{ env "attr.unique.hostname" | toLower }}"
    nomad_namespace  = "{{ env "NOMAD_NAMESPACE" | toLower }}"
    nomad_nodepool   = "{{ env "NOMAD_NODE_POOL" | toLower }}"
    nomad_os         = "{{ env "attr.os.name" | toLower }}"
    nomad_os_version = "{{ env "attr.os.version" | toLower }}"
    nomad_region     = "{{ env "node.region" | toLower }}"

    # TODO: define missing tags
    type   = [[ concat ( var "app_worker_tags" . ) | toJson | ]]
  }
}
[[- end ]]
