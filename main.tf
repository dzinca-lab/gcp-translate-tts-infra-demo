


module "in-bucket" {
  source = "/modules/storage"
  project_id = var.project_id
  bucket_name = "in-bucket-${var.project_id}"
  location = var.gcp_region
  
}

module "out-bucket" {
  source = "/modules/storage" 
  project_id = var.project_id
  bucket_name = "out-bucket-${var.project_id}"
  location = var.gcp_region
  
}