resource "aws_ec2_transit_gateway" "main" {
  description                     = "Centralised Inspection TGW"
  amazon_side_asn                 = 64512
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  tags                            = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-tgw" }
}
