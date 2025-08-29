locals {
  az_a = cidrsubnet(aws_vpc.this.cidr_block, 1, 0)
  az_b = cidrsubnet(aws_vpc.this.cidr_block, 1, 1)

  region_code = lookup(var.vpc_region_shortname, var.vpc_region)
  az_code = {
    0 = lookup(var.vpc_az_shortname, var.vpc_az_list[0])
    1 = lookup(var.vpc_az_shortname, var.vpc_az_list[1])
  }

  prefix = "tfp-${var.env}-net"
  name   = "${local.prefix}-${local.region_code}"

  tags = merge(
    {
      Environment = var.env
    },
    var.tags
  )
}
