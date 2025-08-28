resource "aws_ec2_transit_gateway" "main" {
  description                     = "Centralised Inspection TGW"
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  tags                            = merge(local.tags, { Name = "${local.name}-tgw" })
}
