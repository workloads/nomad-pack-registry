[[- define "util_job_meta" ]]
region      = "[[ var "nomad_job_region" . ]]"
datacenters = [[ var "nomad_job_datacenters" . | toJson ]]
type        = "[[ var "nomad_job_type" . ]]"
namespace   = "[[ var "nomad_job_namespace" . ]]"
priority    = [[ var "nomad_job_priority" . ]]
[[- end ]]
