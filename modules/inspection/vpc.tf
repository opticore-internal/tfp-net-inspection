locals {
  az_a =  cidrsubnet(aws_vpc.this.cidr_block, 1, 0)
  az_b =  cidrsubnet(aws_vpc.this.cidr_block, 1, 1)
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags       = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-vpc" }
}

resource "aws_subnet" "transit_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 0)
  availability_zone = var.vpc_az_list[0]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[0])}-transit" }
}

resource "aws_subnet" "appliance_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 1)
  availability_zone = var.vpc_az_list[0]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[0])}-appliance" }
}

resource "aws_subnet" "public_subnet_az_0"{
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 2)
  availability_zone = var.vpc_az_list[0]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[0])}-public" }
}

resource "aws_subnet" "gwlb_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 3)
  availability_zone = var.vpc_az_list[1]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}-gwlb" }
}

resource "aws_subnet" "gwlbe_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 4)
  availability_zone = var.vpc_az_list[1]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}-gwlbe" }
}


resource "aws_subnet" "transit_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 0)
  availability_zone = var.vpc_az_list[1]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}-transit" }
}
resource "aws_subnet" "appliance_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 1)
  availability_zone = var.vpc_az_list[1]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}-appliance" }
}

resource "aws_subnet" "public_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 2)
  availability_zone = var.vpc_az_list[1]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}-public" }
}

resource "aws_subnet" "gwlb_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 3)
  availability_zone = var.vpc_az_list[1]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}-gwlb" }
}

resource "aws_subnet" "gwlbe_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 4)
  availability_zone = var.vpc_az_list[1]
  tags              = { Name = "tfp-${var.env}-net-vpc-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}-gwlbe" }
}