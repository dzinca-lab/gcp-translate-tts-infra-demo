variable "project_id" {
  type = string
}

variable "gcp_region" {
  type = string
  default = "us-central1"
}

variable "function_translate_name" {
  type = string
  default = "translate-file-http"
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