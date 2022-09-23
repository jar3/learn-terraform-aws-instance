terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "4.31.0"
    }
  }
  backend "s3" {
    bucket = "jhooq-terraform-s3-bucket"
    key    = "jhooq/terraform/remote/s3/terraform.tfstate"
    region     = "eu-central-1"
    dynamodb_table = "dynamodb-state-locking"
    }
}

provider "aws" {
  region = "us-east-2"
  profile = "capatres"
}

variable "infra_env" {
    type = string
    description = "infrastructure environment"
    default = "staging"
}

variable default_region {
    type = string
    description = "the region of this infraestructe is in"
    default = "us-east-2"
}

locals {
    cidr_subnets = cidrsubnets("10.200.0.0/16", 4, 4, 4, 4, 4, 4)
}

module "vpc" {
    source = "../modules/vpc"
    infra_env = var.infra_env
    vpc_cidr = "10.200.0.0/16"
    azs = ["us-east-2a", "us-east-2b", "us-east-2c"]
    #public_subnets = slice(local.cidr_subnets, 0, 3)
    private_subnets = slice(local.cidr_subnets, 3, 6)
}