output "translate_function_name" {
  description = "The name of the Translate Cloud Function"
  value       = google_cloudfunctions_function.translate_function.name
}

output "translate_function_url" {
  description = "The URL of the Translate Cloud Function"
  value       = google_cloudfunctions_function.translate_function.https_trigger_url
}

output "source_bucket_name" {
  description = "The name of the source bucket"
  value       = google_storage_bucket.in_bucket.name
}

output "target_bucket_name" {
  description = "The name of the target bucket"
  value       = google_storage_bucket.out_bucket.name
}

output "audio_bucket_name" {
  description = "The name of the audio bucket"
  value       = google_storage_bucket.audio_bucket.name
}