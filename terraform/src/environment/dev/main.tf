/*
===================================
Provider
===================================
*/
# define provider
provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}


/*
===================================
Module Calls
===================================
*/

# call cloud storage module
module "cloud_storage" {
  source             = "../../shared/modules/cloud-storage"
  bucket_name        = local.bucket_name
  location           = var.location
  storage_class      = "STANDARD"
  force_destroy      = true
  lifecycle_rule_age = 30
}
