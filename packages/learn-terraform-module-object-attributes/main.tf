module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_options = {
    name = var.bucket_name
    prefix = "module-object-attributes-"
  }

  files_options = {
    is_terraform_managed = true
    error_key = "error.html"
    index_key = "index.html"
    static_path = "${path.module}/${var.static_path}"
  }

  tags = var.tags
}