


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
  region  = "<YOUR_REGION>"
  function_name = "translate-file-function"
  runtime       = "python39"
  entry_point   = "translate_file_on_upload"
  source_archive_bucket = "<YOUR_SOURCE_CODE_BUCKET>"
  source_archive_object = "cloud_function_source.zip"
  environment_variables = {
    SOURCE_BUCKET_NAME = "<YOUR_SOURCE_BUCKET_NAME>"
    TARGET_BUCKET_NAME = "<YOUR_TARGET_BUCKET_NAME>"
    TARGET_LANGUAGE   = "fr"
  }
  trigger_http = false
  event_trigger = {
    trigger_event = "google.storage.object.finalize"
    trigger_resource = "projects/<YOUR_PROJECT_ID>/buckets/<YOUR_SOURCE_BUCKET_NAME>"
  }
  memory_size = 256
  timeout = 120
}