module "aws_s3_bucket" {
  source = "./modules/aws-s3-bucket"

  bucket_name = var.bucket_name
  tags = var.tags
}


resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = var.bucket_name

  index_document {
    suffix = var.index_document_suffix
  }

  error_document {
    key = var.error_document_key
  }
  depends_on = [module.aws_s3_bucket]
}

module "template_files" {
  source  = "hashicorp/dir/template"
  version = "1.0.2"

  base_dir = var.static_path != null ? "${path.module}/${var.static_path}" : "${path.module}/www"
}

resource "aws_s3_object" "static_files" {
  for_each = var.terraform_managed_files ? module.template_files.files : {}

  bucket = module.aws_s3_bucket.id

  key          = each.key
  source       = each.value.source_path
  content      = each.value.content
  etag         = each.value.digests.md5
  content_type = each.value.content_type

  depends_on = [module.aws_s3_bucket]
}