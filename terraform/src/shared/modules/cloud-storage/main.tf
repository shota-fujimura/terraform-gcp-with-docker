resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = var.lifecycle_rule_age
    }
  }
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
