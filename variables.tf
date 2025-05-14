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

