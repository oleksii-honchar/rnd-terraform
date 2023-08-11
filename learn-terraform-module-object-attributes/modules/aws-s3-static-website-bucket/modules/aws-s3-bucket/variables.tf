variable "bucket_name" {
  description = "S3 bucket name fot tf state"
  type = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "cors_rules" {
  description = "List of CORS rules."
  type = list(object({
    allowed_headers = optional(set(string)),
    allowed_methods = set(string),
    allowed_origins = set(string),
    expose_headers  = optional(set(string)),
    max_age_seconds = optional(number)
  }))
  default = []
}