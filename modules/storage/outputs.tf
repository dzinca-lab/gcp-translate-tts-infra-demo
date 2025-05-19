output "bucket_name" {
  description = "The name of the storage bucket"
  value       = google_storage_bucket.bucket.name
}

output "bucket_url" {
  description = "The URL of the storage bucket"
  value       = google_storage_bucket.bucket.self_link
}

output "bucket_location" {
  description = "The location of the storage bucket"
  value       = google_storage_bucket.bucket.location
}

output "bucket_storage_class" {
  description = "The storage class of the bucket"
  value       = google_storage_bucket.bucket.storage_class
}