output "translate_function_name" {
  description = "The name of the Translate Cloud Function"
  value       = module.translate_function.function_name
}

output "translate_function_url" {
  description = "The URL of the Translate Cloud Function"
  value       = module.translate_function.function_url
}

output "text_to_speech_function_name" {
  description = "The name of the Text-to-Speech Cloud Function"
  value       = module.text_to_speech_function.function_name
}

output "text_to_speech_function_url" {
  description = "The URL of the Text-to-Speech Cloud Function"
  value       = module.text_to_speech_function.function_url
}

output "source_bucket_name" {
  description = "The name of the source bucket"
  value       = module.in-bucket.bucket_name
}

output "target_bucket_name" {
  description = "The name of the target bucket"
  value       = module.out-bucket.bucket_name
}

output "audio_bucket_name" {
  description = "The name of the audio bucket"
  value       = module.audio-bucket.bucket_name
}