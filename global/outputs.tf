output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "default_region" {
  value = var.default_region
}

output "state_bucket_name" {
  value = var.state_bucket_name
}
