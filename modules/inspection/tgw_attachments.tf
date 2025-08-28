resource "aws_ec2_transit_gateway_vpc_attachment" "inspection" {
  vpc_id             = aws_vpc.this.id
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  subnet_ids = [
    aws_subnet.transit_subnet_az_0.id,
    aws_subnet.transit_subnet_az_1.id
  ]

  appliance_mode_support                          = "enable"
  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = merge(local.tags, { Name = "${local.name}-inspection-tgw-attachment" })
}

resource "aws_ec2_transit_gateway_route_table_association" "inspection_assoc_to_spoke_rt" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_rt.id
}
