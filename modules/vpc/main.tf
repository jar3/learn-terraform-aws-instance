resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "eks-cluster-production-node-${var.infra_env}-vpc"
    ManageBy = "terraform"
  }
}

# resource "aws_subnet" "public" {
#   for_each = var.public_subnet_numbers
#   vpc_id = aws_vpc.vpc.id
#   cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)
#   tags = {
#     Name = "eks-cluster-production-node-${var.infra_env}-public-subnet"
#     Project = "Wispro"
#     Role = "public"
#     Environment = var.infra_env
#     ManageBy = "terraform"
#     Subnet = "${each.key}- ${each.value}"
#   }
# }

resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)
  tags = {
    Name = "eks-cluster-production-node-${var.infra_env}-private-subnet"
    Project = "Wispro"
    Role = "private"
    Environment = var.infra_env
    ManageBy = "terraform"
    Subnet = "${each.key}- ${each.value}"
  }
}

