resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags       = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-vpc" }
}

