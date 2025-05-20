locals {
  apis_config = yamldecode(file("./config/gcp_apis.yml"))
  api_list    = local.apis_config.apis
}

resource "google_project_service" "enabled_apis" {
  for_each           = toset(local.api_list)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}