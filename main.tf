locals {
  translate_function_name= "translate-function"
  speech_function_name= "text-to-speech-function"
}

module "enable_apis" {
  source     = "./modules/project_apis"
  project_id = var.project_id
}

module "in-bucket" {
  source = "./modules/storage"
  project_id = var.project_id
  bucket_name = "in-bucket-${var.project_id}"
  location = var.gcp_region
  
}

module "out-bucket" {
  source = "./modules/storage" 
  project_id = var.project_id
  bucket_name = "out-bucket-${var.project_id}"
  location = var.gcp_region
  
}


module "audio-bucket" {
  source = "./modules/storage" 
  project_id = var.project_id
  bucket_name = "audio-bucket-${var.project_id}"
  location = var.gcp_region
  
}





module "translate_function" {
  source = "./modules/cloud_function"
  project_id = var.project_id
  gcp_region = var.gcp_region
  python_version = "python${var.python_version}"
  function_name = local.translate_function_name
  code_bucket_suffix = var.code_bucket_suffix
  code_bucket_name =  "${var.project_id}-${ var.code_bucket_suffix }"
  cloud_function_archive = "${var.cloud_function_archive_prefix}-${ local.translate_function_name }.zip"
  source_bucket_name = module.in-bucket.bucket_name
  target_bucket_name = module.out-bucket.bucket_name
  target_language = var.target_language
  function_entry_point = "translate_file_on_upload"
  depends_on = [module.in-bucket, module.out-bucket]
  
}

module "text_to_speech_function" {
  source = "./modules/cloud_function"
  project_id = var.project_id
  gcp_region = var.gcp_region
  python_version = "python${var.python_version}"
  function_name = local.speech_function_name
  code_bucket_suffix = var.code_bucket_suffix
  code_bucket_name = "${var.project_id}-${ var.code_bucket_suffix }"
  cloud_function_archive = "${var.cloud_function_archive_prefix}-${ local.speech_function_name  }.zip"
  source_bucket_name = module.out-bucket.bucket_name
  target_bucket_name = module.audio-bucket.bucket_name
  target_language = var.target_language
  function_entry_point = "text_to_speech_converter"
  depends_on = [module.in-bucket, module.out-bucket]
  
}