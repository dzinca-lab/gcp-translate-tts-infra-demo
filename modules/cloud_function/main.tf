
resource "google_cloudfunctions_function" "translate_function" {
  name        = var.function_translate_name
  description = "Cloud Function to translate files"
  runtime     = "python39"
  project     = var.project_id
  region      = var.gcp_region
  available_memory_mb = 256
  source_archive_bucket = var.code_bucket_name
  source_archive_object = var.cloud_function_translate_archive
    event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = var.source_bucket_name
  }
  entry_point           = "translate_file_on_upload" # Assuming your function entry point
  environment_variables = {
    SOURCE_BUCKET_NAME = var.source_bucket_name
    TARGET_BUCKET_NAME = var.target_bucket_name
    TARGET_LANGUAGE   = var.target_language
  }
}