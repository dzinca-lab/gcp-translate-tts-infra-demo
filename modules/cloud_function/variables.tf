variable "project_id" {
  type = string
}

variable "gcp_region" {
  type = string
  default = "us-central1"
}

variable "function_translate_name" {
  type = string

}

variable "cloud_function_translate_archive" {
  type = string
  default = "cloud_function_translate_source.zip"
  
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
  default = "fr"
}