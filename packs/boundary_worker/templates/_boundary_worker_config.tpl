[[- define "boundary_worker_config" ]]
# see https://developer.hashicorp.com/boundary/docs/configuration#disable_mlock
disable_mlock = [[ var "app_disable_mlock" . ]]

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
  cors_enabled = [[ var "app_cors_enabled" . ]]

  cors_allowed_origins = [[ concat ( var "app_cors_allowed_origins" . ) | toJson ]]
}
[[- end ]]

[[ if var "nomad_group_ports.ops" . ]]
# see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp
listener "tcp" {
  address = "{{ env "NOMAD_ADDR_ops" }}"

  # see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp#purpose
  purpose = "ops"

  # see https://developer.hashicorp.com/boundary/docs/configuration/listener/tcp#tls
  tls_disable                        = [[ var "app_tls_disable" . ]]

  [[ if (ne (var "app_tls_client_ca_file" . ) "") -]]
  tls_client_ca_file                 = "[[ var "app_tls_client_ca_file" . ]]"
  [[ end -]]

  [[ if (ne (var "app_tls_cert_file" . ) "") -]]
  tls_cert_file                      = "[[ var "app_tls_cert_file" . ]]"
  [[ end -]]

  [[ if (ne (var "app_tls_key_file" . ) "") -]]
  tls_key_file                       = "[[ var "app_tls_key_file" . ]]"
  [[ end -]]

  tls_min_version                    = "[[ var "app_tls_min_version" . ]]"
  tls_max_version                    = "[[ var "app_tls_max_version" . ]]"

  [[- if (ne (var "app_tls_cipher_suites" . ) "") -]]
  tls_cipher_suites                  = "[[ var "app_tls_cipher_suites" . ]]"
  [[ end -]]

  tls_prefer_server_cipher_suites    = [[ var "app_tls_prefer_server_cipher_suites" . ]]
  tls_require_and_verify_client_cert = [[ var "app_tls_require_and_verify_client_cert" . ]]
}
[[ end ]]

# see https://developer.hashicorp.com/boundary/docs/configuration/worker
worker {
  # see https://developer.hashicorp.com/boundary/tutorials/hcp-administration/hcp-manage-workers#auth_storage_path
  auth_storage_path = "{{ env "NOMAD_SECRETS_DIR" }}/auth"

  # see https://developer.hashicorp.com/boundary/docs/configuration/worker#public_addr
  public_addr = "{{ env "NOMAD_ADDR_proxy" }}"

  # This is a single-use token; it is safe to be stored in a task-wide accessible directory
  # see https://developer.hashicorp.com/boundary/docs/configuration/worker/pki-worker#controller-led-authorization-flow
  controller_generated_activation_token = "file:///{{ env "NOMAD_ALLOC_DIR" }}/worker_activation_token"

  # see https://developer.hashicorp.com/boundary/docs/configuration/worker#tags
  # and https://developer.hashicorp.com/nomad/docs/runtime/interpolation#node-attributes
  tags {
    [[- if (ne (env "attr.consul.datacenter") "") -]]
    # Consul-specific tags
    consul_datacenter = "{{ env "attr.consul.datacenter" | toLower }}"
    [[ end -]]
    [[ if (ne (env "attr.consul.version") "") -]]
    consul_version    = "{{ env "attr.consul.version" | toLower }}"
    [[ end ]]

    # Nomad-specific tags
    nomad_alloc_id          = "{{ env "NOMAD_ALLOC_ID" | toLower }}"
    nomad_client            = "{{ env "node.unique.name" | toLower }}"
    nomad_dc                = "{{ env "node.datacenter" | toLower }}"
    nomad_hostname          = "{{ env "attr.unique.hostname" | toLower }}"
    nomad_namespace         = "{{ env "NOMAD_NAMESPACE" | toLower }}"

    [[- if (ne (env "node.class") "") ]]
    nomad_node_class        = "{{ env "node.class" | toLower }}"
    [[ end ]]
    [[- if (ne (env "node.pool") "") ]]
    nomad_node_pool         = "{{ env "node.pool" | toLower }}"
    [[ end ]]

    nomad_os                = "{{ env "attr.os.name" | toLower }}"
    nomad_os_version        = "{{ env "attr.os.version" | toLower }}"
    nomad_region            = "{{ env "node.region" | toLower }}"
    nomad_service_discovery = "{{ env "attr.nomad.service.discovery" | toLower }}"
    nomad_version           = "{{ env "attr.nomad.version" | toLower }}"

    [[- if (ne (env "attr.vault.version") "") ]]
    # Vault-specific tags
    vault_version = "{{ env "attr.vault.version" | toLower }}"
    [[ end ]]
  }
}
[[- end ]]
