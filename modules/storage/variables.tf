variable "bucket_name" {
  description = "The name of the storage bucket"
  type        = string
}

variable "location" {
  description = "The location where the storage bucket will be created"
  type        = string
  default     = "US"
}

variable "project_id" {
  description = "The ID of the Google Cloud Project"
  type        = string
}



variable "function_speech_name" {
  type = string
  default = "text-to-speech-function"
  description = "Name of the Cloud Function for text-to-speech"
  
}