module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = var.bucket_name
  bucket_prefix = "module-object-attributes-"
  terraform_managed_files = true

  tags = var.tags
}