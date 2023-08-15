# Input variable definitions
variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "bucket_options" {
  description = "Static content S3 bucket options"
  type = object({
    name = string # Name of the s3 bucket. Must be unique.
    prefix = string # Prefix for the s3 bucket name. Conflicts with `bucket_name`
  })
}

variable "files_options" {
  description = "Configuration for website files."
  type = object({
    is_terraform_managed = bool
    error_key = optional(string, "error.html")
    index_key = optional(string, "index.html")
    static_path = optional(string)
  })
}
