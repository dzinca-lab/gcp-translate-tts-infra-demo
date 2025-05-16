variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud Project"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region to deploy resources in"
  default     = "us-central1"
}

# Optional variables
variable "gcp_zone" {
  type        = string
  description = "The GCP zone to deploy resources in"
  default     = null
}

variable "function_translate_name" {
  type = string
  default = "translate-function"
  description = "Name of the Cloud Function for file translation"
}

variable "target_language" {
  type = string
  default = "fr"
}



variable "cloud_function_translate_archive" {
  type = string
  description = "The name of the archive file for the Cloud Function"
  
}