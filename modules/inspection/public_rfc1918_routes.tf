resource "aws_route" "public_rfc1918a_az_0" {
  count                  = var.public_rfc1918_through_gwlbe ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_0.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}

resource "aws_route" "public_rfc1918b_az_0" {
  count                  = var.public_rfc1918_through_gwlbe ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_0.id
  destination_cidr_block = "172.16.0.0/12"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}

resource "aws_route" "public_rfc1918c_az_0" {
  count                  = var.public_rfc1918_through_gwlbe ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_0.id
  destination_cidr_block = "192.168.0.0/16"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}

resource "aws_route" "public_rfc1918a_az_1" {
  count                  = var.public_rfc1918_through_gwlbe ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_1.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}

resource "aws_route" "public_rfc1918b_az_1" {
  count                  = var.public_rfc1918_through_gwlbe ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_1.id
  destination_cidr_block = "172.16.0.0/12"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}

resource "aws_route" "public_rfc1918c_az_1" {
  count                  = var.public_rfc1918_through_gwlbe ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_1.id
  destination_cidr_block = "192.168.0.0/16"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}

