output "arn" {
  description = "ARN of the bucket"
  value       = module.aws_s3_bucket.arn
}

output "id" {
  description = "ID of the bucket"
  value       = module.aws_s3_bucket.id
}

output "domain" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket_website_configuration.s3_bucket.website_domain
}

output "endpoint" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket_website_configuration.s3_bucket.website_endpoint
}
