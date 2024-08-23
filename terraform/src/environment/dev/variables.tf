variable "env" {
  description = "The environment name"
  type        = string
}

variable "credentials_file" {
  description = "Path to the Google Cloud credentials file"
  type        = string
}

variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "asia-northeast1"
}

variable "location" {
  description = "The location of the bucket"
  type        = string
  default     = "asia-northeast1"
}

variable "database_password" {
  description = "The password for the database user"
  type        = string
  sensitive   = true
}