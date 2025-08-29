resource "aws_subnet" "transit_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 0)
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[0]}-transit" })
}
resource "aws_subnet" "transit_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 0)
  availability_zone = var.vpc_az_list[1]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[1]}-transit" })
}
resource "aws_subnet" "gwlbe_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 1)
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[0]}-gwlbe" })
}
resource "aws_subnet" "gwlbe_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 1)
  availability_zone = var.vpc_az_list[1]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[1]}-gwlbe" })
}
resource "aws_subnet" "gwlb_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 2)
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[0]}-gwlb" })
}
resource "aws_subnet" "gwlb_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 2)
  availability_zone = var.vpc_az_list[1]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[1]}-gwlb" })
}

resource "aws_subnet" "appliance_subnet_az_0" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 3)
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[0]}-appliance" })
}
resource "aws_subnet" "appliance_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 3)
  availability_zone = var.vpc_az_list[1]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[1]}-appliance" })
}
resource "aws_subnet" "public_subnet_az_0"{
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 4)
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[0]}-public" })
}
resource "aws_subnet" "public_subnet_az_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 4)
  availability_zone = var.vpc_az_list[1]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[1]}-public" })
}
resource "aws_subnet" "mgmt_subnet_az_0"{
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_a, 6, 5)
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[0]}-public" })
}
resource "aws_subnet" "mgmt_subnet_az_1"{
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.az_b, 6, 5)
  availability_zone = var.vpc_az_list[1]
  tags              = merge(local.tags, { Name = "${local.name}-vpc-${local.az_code[1]}-public" })
}
















