
resource "google_service_account" "translate_function_sa" {
  account_id   = "${var.function_translate_name}-sa"
  display_name = "Service Account for ${var.function_translate_name}"
}


resource "google_project_iam_member" "translate_function_sa_storage_access" {
  for_each = toset([
    "roles/storage.objectViewer",  # Read access to source bucket
    "roles/storage.objectCreator" # Write access to target bucket
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.translate_function_sa.email}"
}


resource "google_project_iam_member" "translate_function_sa_cloudfunctions_invoker" {
  project = var.project_id
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.translate_function_sa.email}"
}

# Update the Cloud Function to use the service account
resource "google_cloudfunctions_function" "translate_function" {
  name        = var.function_translate_name
  description = "Cloud Function to translate files"
  runtime     = var.python_version
  project     = var.project_id
  region      = var.gcp_region
  available_memory_mb = 256
  source_archive_bucket = var.code_bucket_name
  source_archive_object = var.cloud_function_translate_archive
  service_account_email = google_service_account.translate_function_sa.email

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = var.source_bucket_name
  }

  entry_point           = "translate_file_on_upload" # Assuming your function entry point
  environment_variables = {
    SOURCE_BUCKET_NAME = var.source_bucket_name
    TARGET_BUCKET_NAME = var.target_bucket_name
    TARGET_LANGUAGE    = var.target_language
  }
}