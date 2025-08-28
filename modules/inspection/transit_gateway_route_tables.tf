resource "aws_ec2_transit_gateway_route_table" "inspection_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags               = merge(local.tags, { Name = "${local.name}-inspection-rt" })
}

resource "aws_ec2_transit_gateway_route_table" "spoke_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags               = merge(local.tags, { Name = "${local.name}-spoke-rt" })
}
