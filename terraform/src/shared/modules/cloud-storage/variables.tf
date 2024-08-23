variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "location" {
  description = "The location of the bucket"
  type        = string
  default     = "asia-northeast1"
}

variable "storage_class" {
  description = "The storage class of the bucket"
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "The force destroy of the bucket"
  type        = bool
}

variable "lifecycle_rule_age" {
  description = "The lifecycle rule age of the bucket"
  type        = number
  default     = 30
}
