terraform {
  backend "gcs" {
    bucket = "sample-app-dev-tfstate-bucket"
    prefix = "terraform/state"
  }
}