resource "google_storage_bucket" "default" {
  name     = var.bucket_name
  location = var.location
  project  = var.project_id

  force_destroy = false

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }
}
