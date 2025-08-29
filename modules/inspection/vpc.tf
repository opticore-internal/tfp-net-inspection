resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags       = merge(local.tags, { Name = "${local.name}-inspection-vpc" })
}
