variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud Project"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region to deploy resources in"

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


variable "target_language" {
  type = string
}



variable "cloud_function_archive_prefix" {
  type = string
  description = "The name of the archive file for the Cloud Function"
  
}

variable "python_version" {
  type = string

  
}


variable "code_bucket_suffix" {
  type = string

  
}


variable "function_name" {
  type = string

}