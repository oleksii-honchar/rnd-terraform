terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67"
    }
  }
}

#module "vpc" {
#  source  = "terraform-aws-modules/vpc/aws"
#  version = "3.18.1"
#
#  name = var.vpc_name
#  cidr = var.vpc_cidr
#
#  azs             = var.vpc_azs
#  private_subnets = var.vpc_private_subnets
#  public_subnets  = var.vpc_public_subnets
#
#  enable_nat_gateway = var.vpc_enable_nat_gateway
#
#  tags = var.vpc_tags
#}
