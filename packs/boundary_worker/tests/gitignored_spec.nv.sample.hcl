# The root-level Makefile will automatically map these variables this file if it is renamed to `gitignored_spec.nv.hcl`.
# This file may be used to set sensitive variables for testing purposes.

items {
  # general configuration
  log_level="warn"

  # Boundary-specific configuration
  boundary_auth_method_id="ampw_..."
  boundary_password="..."
  boundary_scope_id="global"
  boundary_username="cluster-admin"
  boundary_worker_cleanup_period="180h"

  # HCP Boundary-specific configuration
  hcp_boundary_cluster_id="..."
}
