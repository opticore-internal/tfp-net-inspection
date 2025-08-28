# Create the Transit Gateway
resource "aws_ec2_transit_gateway" "main" {
  description                     = "Centralised Inspection TGW"
  amazon_side_asn                 = 64512
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  #tags                           = { Name = "centralised-inspection-tgw" }
#  tags                           = { Name = "tfp-${var.env}-net-tgw-${lookup(var.vpc_az_shortname,var.vpc_az_list[1])}
  tags                            = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-tgw" }
}


 

# TGW Route Table for inspection traffic to appliances (routing steer)
resource "aws_ec2_transit_gateway_route_table" "inspection_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags                          = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-inspection-rt" }
}

# TGW Route Table for spokes traffic from appliances (routing steer)
resource "aws_ec2_transit_gateway_route_table" "spoke_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags                          = { Name = "tfp-${var.env}-net-${lookup(var.vpc_region_shortname,var.vpc_region)}-spoke-rt" }
}
