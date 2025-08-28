locals {
  az_a =  cidrsubnet(aws_vpc.this.cidr_block, 1, 0)
  az_b =  cidrsubnet(aws_vpc.this.cidr_block, 1, 1)
}