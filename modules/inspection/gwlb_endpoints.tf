# GWLB Endpoints (one per AZ)
resource "aws_vpc_endpoint" "gwlb_endpoint_az_0" {
  vpc_id            = aws_vpc.this.id
  service_name      = aws_vpc_endpoint_service.gwlb.service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids        = [aws_subnet.gwlbe_subnet_az_0.id]
  tags              = merge(local.tags, { Name = "${local.prefix}-gwlbe-${local.az_code[0]}" })
}

resource "aws_vpc_endpoint" "gwlb_endpoint_az_1" {
  vpc_id            = aws_vpc.this.id
  service_name      = aws_vpc_endpoint_service.gwlb.service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids        = [aws_subnet.gwlbe_subnet_az_1.id]
  tags              = merge(local.tags, { Name = "${local.prefix}-gwlbe-${local.az_code[1]}" })
}
