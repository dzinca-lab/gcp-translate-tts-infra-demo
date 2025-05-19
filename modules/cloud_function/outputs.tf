output "function_name" {
  description = "The name of the Cloud Function"
  value       = google_cloudfunctions_function.function.name
}

output "function_url" {
  description = "The URL of the Cloud Function"
  value       = google_cloudfunctions_function.function.https_trigger_url
}

output "function_runtime" {
  description = "The runtime of the Cloud Function"
  value       = google_cloudfunctions_function.function.runtime
}

output "function_service_account" {
  description = "The service account used by the Cloud Function"
  value       = google_cloudfunctions_function.function.service_account_email
}