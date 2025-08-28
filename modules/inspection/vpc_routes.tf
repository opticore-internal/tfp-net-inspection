resource "aws_route" "public_default_az_0" {
  route_table_id         = aws_route_table.public_rt_az_0.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route" "public_default_az_1" {
  route_table_id         = aws_route_table.public_rt_az_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route" "transit_default_az_0" {
  route_table_id         = aws_route_table.transit_rt_az_0.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}

resource "aws_route" "transit_az_0_to_public_az_0" {
  route_table_id         = aws_route_table.transit_rt_az_0.id
  destination_cidr_block = aws_subnet.public_subnet_az_0.cidr_block
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}

resource "aws_route" "transit_az_0_to_public_az_1" {
  route_table_id         = aws_route_table.transit_rt_az_0.id
  destination_cidr_block = aws_subnet.public_subnet_az_1.cidr_block
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}

resource "aws_route" "transit_default_az_1" {
  route_table_id         = aws_route_table.transit_rt_az_1.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}

resource "aws_route" "transit_az_1_to_public_az_0" {
  route_table_id         = aws_route_table.transit_rt_az_1.id
  destination_cidr_block = aws_subnet.public_subnet_az_0.cidr_block
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}

resource "aws_route" "transit_az_1_to_public_az_1" {
  route_table_id         = aws_route_table.transit_rt_az_1.id
  destination_cidr_block = aws_subnet.public_subnet_az_1.cidr_block
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}

resource "aws_route" "appliance_to_tgw_az_0" {
  route_table_id         = aws_route_table.appliance_rt_az_0.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

resource "aws_route" "appliance_to_tgw_az_1" {
  route_table_id         = aws_route_table.appliance_rt_az_1.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

resource "aws_route" "gwlbe_to_tgw" {
  route_table_id         = aws_route_table.gwlbe_rt.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

