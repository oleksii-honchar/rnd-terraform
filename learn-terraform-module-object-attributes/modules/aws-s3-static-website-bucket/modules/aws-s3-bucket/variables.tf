variable "bucket_name" {
  description = "S3 bucket name fot tf state"
  type = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}