module "aws_s3_bucket" {
  source = "./modules/aws-s3-bucket"

  bucket_name = var.bucket_name
  tags = var.tags
}


resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = var.bucket_name

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [module.aws_s3_bucket]
}
