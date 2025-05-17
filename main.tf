


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


module "translate_function" {
  source = "./modules/cloud_function"
  project_id = var.project_id
  gcp_region = var.gcp_region
  python_version = "python${var.python_version}"
  function_translate_name = var.function_translate_name
  code_bucket_name =  var.code_bucket_name
  cloud_function_translate_archive = var.cloud_function_translate_archive
  source_bucket_name = "in-bucket-${var.project_id}"
  target_bucket_name = "out-bucket-${var.project_id}"
  target_language = var.target_language
  depends_on = [module.in-bucket, module.out-bucket]
  
}