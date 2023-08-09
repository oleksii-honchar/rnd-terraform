# Input variable definitions
variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
  default = null
}

variable "bucket_prefix" {
  description = "Prefix for the s3 bucket name. Conflicts with `bucket_name`."
  type        = string
  default     = null
}

variable "index_document_suffix" {
  description = "Suffix for index documents."
  type        = string
  default     = "index.html"
}

variable "error_document_key" {
  description = "Key for error document."
  type        = string
  default     = "error.html"
}

variable "static_path" {
  description = "Local relative path containing files to upload to website bucket"
  type        = string
  default     = "static"
}

variable "terraform_managed_files" {
  description = "Flag to indicate whether Terraform should upload files to the bucket."
  type        = bool
  default     = true
}