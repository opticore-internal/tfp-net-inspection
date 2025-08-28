resource "aws_route_table" "public_rt_az_0" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "${local.prefix}-public-rt-${local.az_code[0]}" })
}

resource "aws_route_table_association" "public_assoc_az_0" {
  subnet_id      = aws_subnet.public_subnet_az_0.id
  route_table_id = aws_route_table.public_rt_az_0.id
}

resource "aws_route_table" "public_rt_az_1" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "${local.prefix}-public-rt-${local.az_code[1]}" })
}

resource "aws_route_table_association" "public_assoc_az_1" {
  subnet_id      = aws_subnet.public_subnet_az_1.id
  route_table_id = aws_route_table.public_rt_az_1.id
}

resource "aws_route_table" "transit_rt_az_0" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "${local.prefix}-transit-rt-${local.az_code[0]}" })
}

resource "aws_route_table_association" "transit_assoc_az_0" {
  subnet_id      = aws_subnet.transit_subnet_az_0.id
  route_table_id = aws_route_table.transit_rt_az_0.id
}

resource "aws_route_table" "transit_rt_az_1" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "${local.prefix}-transit-rt-${local.az_code[1]}" })
}

resource "aws_route_table_association" "transit_assoc_az_1" {
  subnet_id      = aws_subnet.transit_subnet_az_1.id
  route_table_id = aws_route_table.transit_rt_az_1.id
}

resource "aws_route_table" "appliance_rt_az_0" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "${local.prefix}-appliance-rt-${local.az_code[0]}" })
}

resource "aws_route_table_association" "appliance_assoc_az_0" {
  subnet_id      = aws_subnet.appliance_subnet_az_0.id
  route_table_id = aws_route_table.appliance_rt_az_0.id
}

resource "aws_route_table_association" "gwlb_assoc_az_0" {
  subnet_id      = aws_subnet.gwlb_subnet_az_0.id
  route_table_id = aws_route_table.appliance_rt_az_0.id
}

resource "aws_route_table" "appliance_rt_az_1" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "${local.prefix}-appliance-rt-${local.az_code[1]}" })
}

resource "aws_route_table_association" "appliance_assoc_az_1" {
  subnet_id      = aws_subnet.appliance_subnet_az_1.id
  route_table_id = aws_route_table.appliance_rt_az_1.id
}

resource "aws_route_table_association" "gwlb_assoc_az_1" {
  subnet_id      = aws_subnet.gwlb_subnet_az_1.id
  route_table_id = aws_route_table.appliance_rt_az_1.id
}

resource "aws_route_table" "gwlbe_rt" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "${local.prefix}-gwlbe-rt" })
}

resource "aws_route_table_association" "gwlbe_assoc_az_0" {
  subnet_id      = aws_subnet.gwlbe_subnet_az_0.id
  route_table_id = aws_route_table.gwlbe_rt.id
}

resource "aws_route_table_association" "gwlbe_assoc_az_1" {
  subnet_id      = aws_subnet.gwlbe_subnet_az_1.id
  route_table_id = aws_route_table.gwlbe_rt.id
}
