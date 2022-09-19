terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "4.30.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  profile = "capatres"
}


resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "eks-cluster-production-node-${var.infra-env}-vpc"
    ManageBy = "terraform"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cdr_clock, 4, each.value)
  tags = {
    Name = "eks-cluster-production-node-${var.infra-env}-public-subnet"
    Project = "Wispro"
    Role = "public"
    Environment = var.infra_env
    ManageBy = "terraform"
    Subnet = "${each.key}- ${each.value}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cdr_clock, 4, each.value)
  tags = {
    Name = "eks-cluster-production-node-${var.infra-env}-private-subnet"
    Project = "Wispro"
    Role = "private"
    Environment = var.infra_env
    ManageBy = "terraform"
    Subnet = "${each.key}- ${each.value}"
  }
}

