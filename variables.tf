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

variable "code_bucket_name" {
  type        = string
  description = "The name of the bucket where the Cloud Function code is stored"
  
}

variable "function_name" {
  type = string
  default = "translate-function"
  description = "Name of the Cloud Function for file translation"
}

variable "target_language" {
  type = string
}



variable "cloud_function_archive" {
  type = string
  description = "The name of the archive file for the Cloud Function"
  
}

variable "python_version" {
  type = string

  
}


variable "code_bucket_suffix" {
  type = string

  
}

variable "function_entry_point" {
  type = string
  description = "The entry point for the Cloud Function"
  
}

variable "function_name" {
  type = string
  default = "text-to-speech-function"
  description = "Name of the Cloud Function for text-to-speech"
  
}

