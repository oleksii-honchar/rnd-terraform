# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
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
