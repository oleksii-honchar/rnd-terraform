# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket  = "olho.rnd.terraform-state"
    encrypt = true
    key     = "learn-s3-bucket/terraform.tfstate"
    region  = "eu-central-1"
  }
}
