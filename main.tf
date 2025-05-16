


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


module "cloud_function" {
  source = "./modules/cloud_function"
  project_id = var.project_id
  gcp_region = var.gcp_region
  function_translate_name = var.function_translate_name
  code_bucket_name =  "ttts-code-${var.project_id}"
  source_bucket_name = "in-bucket-${var.project_id}"
  target_bucket_name = "out-bucket-${var.project_id}"
  target_language = var.target_language
  depends_on = [module.in-bucket, module.out-bucket]
  
}