# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Input variable definitions

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {
    Project = "static-website-object"
    Environment = "development"
  }
}
variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
  default = "olho.rnd.web-s3-content"
}

variable "static_path" {
  description = "Local relative path containing files to upload to website bucket"
  type        = string
  default     = "static"
}