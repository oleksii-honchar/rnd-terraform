module "aws_s3_bucket" {
  source = "./modules/aws-s3-bucket"

  bucket_name = var.bucket_options.name
  tags = var.tags
  cors_rules = [{
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }]

}


resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = var.bucket_options.name

  index_document {
    suffix = var.files_options.index_key
  }

  error_document {
    key = var.files_options.error_key
  }
  depends_on = [module.aws_s3_bucket]
}

module "template_files" {
  source  = "hashicorp/dir/template"
  version = "1.0.2"

  base_dir = var.files_options.static_path != null ? var.files_options.static_path : "${path.module}/www"
}

resource "aws_s3_object" "static_files" {
  for_each = var.files_options.is_terraform_managed ? module.template_files.files : {}

  bucket = module.aws_s3_bucket.id

  key          = each.key
  source       = each.value.source_path
  content      = each.value.content
  etag         = each.value.digests.md5
  content_type = each.value.content_type

  depends_on = [module.aws_s3_bucket]
}