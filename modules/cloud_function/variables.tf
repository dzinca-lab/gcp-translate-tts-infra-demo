# modules/cloud_function_translation/variables.tf
variable "project_id" {
  type = string
  description = "The ID of your Google Cloud project"
}

variable "gcp_region" {
  type    = string
  description = "The Google Cloud region to deploy resources in"
  default = "us-central1"
}

variable "code_bucket_name" {
  type        = string
  description = "The name of the GCS bucket to store the Cloud Function source code"
}

variable "function_name" {
  type        = string
  description = "The name of the Cloud Function"
  default     = "translate-file-function"
}

variable "runtime" {
  type    = string
  description = "The runtime environment for the Cloud Function"
  default = "python39"
}

variable "entry_point" {
  type        = string
  description = "The entry point for the Cloud Function"
  default     = "translate_file_on_upload"
}

variable "source_archive_object" {
  type        = string
  description = "The name of the archive in the source bucket"
  default     = "cloud_function_source.zip"
}

variable "environment_variables" {
  type = map(string)
  description = "Environment variables for the Cloud Function"
  default = {
    SOURCE_BUCKET_NAME = ""
    TARGET_BUCKET_NAME = ""
    TARGET_LANGUAGE   = "fr"
  }
}

variable "event_trigger" {
  type = object({
    trigger_event  = string
    trigger_resource = string
  })
  description = "The event trigger for the Cloud Function"
  default = {
    trigger_event  = "google.storage.object.finalize"
    trigger_resource = ""
  }
}

variable "memory_size" {
  type    = number
  description = "The amount of memory allocated to the function"
  default = 256
}

variable "timeout" {
  type    = number
  description = "The timeout for the function"
  default = 120
}

variable "sa_account_id" {
  type = string
  description = "The service account account ID"
  default = "translate-file-function-sa"
}

# modules/cloud_function_translation/outputs.tf
output "function_name" {
  value       = google_cloudfunctions_function.function.name
  description = "The name of the deployed Cloud Function"
}

output "source_code_bucket" {
  value = google_storage_bucket.cloud_function_source_code.name
  description = "The name of the bucket where the source code is stored."
}
