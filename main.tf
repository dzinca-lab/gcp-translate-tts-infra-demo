


module "in-bucket" {
  source = "./modules/storage"
  project_id = var.project_id
  bucket_name = "in-bucket-${var.project_id}"
  location = var.gcp_region
  
}

module "out-bucket" {
  source = "./modules/storage" 
  project_id = var.project_id
  bucket_name = "out-bucket-${var.project_id}"
  location = var.gcp_region
  
}


module "cloud_function_translation" {
  source = "hashicorp/google"
  version = ">= 4.0.0"
  project = var.project_id
  region  = var.gcp_region
  function_name = "translate-file-function"
  runtime       = "python39"
  entry_point   = "translate_file_on_upload"
  source_archive_bucket = "cloud_function_translate_source.zip"
  source_archive_object = "cloud_function_source.zip"
  environment_variables = {
    SOURCE_BUCKET_NAME ="in-bucket-${var.project_id}"
    TARGET_BUCKET_NAME = "out-bucket-${var.project_id}"
    TARGET_LANGUAGE   = "fr"
  }
  trigger_http = false
  event_trigger = {
    trigger_event = "google.storage.object.finalize"
    trigger_resource = "projects/${var.project_id}/buckets/in-bucket-${var.project_id}"
  }
  memory_size = 256
  timeout = 120
}