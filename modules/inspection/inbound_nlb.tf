resource "aws_security_group" "nlb_sg" {
  count       = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  name        = "nlb-sg"
  description = "Allow all traffic for NLB"
  vpc_id      = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.tags, { Name = "${local.name}-nlb-sg" })
}

resource "aws_lb" "nlb" {
  count              = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  name               = "inbound-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb_sg[0].id]
  subnets            = [aws_subnet.public_subnet_az_0.id, aws_subnet.public_subnet_az_1.id]
  tags               = merge(local.tags, { Name = "${local.name}-inbound-nlb" })
}

resource "aws_route" "public_rfc1918a_az_0" {
  count                  = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_0.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}
resource "aws_route" "public_rfc1918b_az_0" {
  count                  = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_0.id
  destination_cidr_block = "172.16.0.0/12"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}
resource "aws_route" "public_rfc1918c_az_0" {
  count                  = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_0.id
  destination_cidr_block = "192.168.0.0/16"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_0.id
}
resource "aws_route" "public_rfc1918a_az_1" {
  count                  = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_1.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}
resource "aws_route" "public_rfc1918b_az_1" {
  count                  = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_1.id
  destination_cidr_block = "172.16.0.0/12"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}
resource "aws_route" "public_rfc1918c_az_1" {
  count                  = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  route_table_id         = aws_route_table.public_rt_az_1.id
  destination_cidr_block = "192.168.0.0/16"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_az_1.id
}