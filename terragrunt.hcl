remote_state {
  backend = "s3"
  generate = {
    path      = "backend-s3.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "olho.rnd.terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}

generate "variables-global" {
  path = "variables-global.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "state_bucket_name" {
  description = "S3 bucket name fot tf state"
  type = string
  default = "olho.rnd.terraform-state"
}

variable "default_region" {
  description = "AWS EU default region"
  type = string
  default = "eu-central-1"
}
EOF
}

generate "aws-provider" {
  path = "provider-aws.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = var.default_region

  default_tags {
    tags = {
      hashicorp-learn = "module-use"
    }
  }
}
EOF
}