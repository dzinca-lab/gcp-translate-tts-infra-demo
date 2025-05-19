variable "project_id" {
  type = string
}

variable "gcp_region" {
  type = string
  default = "us-central1"
}

variable "function_name" {
  type = string

}

variable "cloud_function_archive" {
  type = string
  
}

variable "code_bucket_name" {
  type = string
}

variable "source_bucket_name" {
  type = string
}

variable "target_bucket_name" {
  type = string
}

variable "target_language" {
  type = string

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