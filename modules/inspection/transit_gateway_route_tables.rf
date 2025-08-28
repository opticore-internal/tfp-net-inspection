resource "aws_ec2_transit_gateway_route_table" "inspection_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags                          = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-inspection-rt" }
}

resource "aws_ec2_transit_gateway_route_table" "spoke_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags                          = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-spoke-rt" }
}
