provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "az" {
  state = "available"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 0)
  availability_zone = data.aws_availability_zones.az.names[0]

  tags = {
    "Name"      = "pub-subnet"
    "Workspace" = terraform.workspace
  }
}
