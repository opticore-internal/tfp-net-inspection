output "vpc_cidr_block" {
  description = "The CIDR block for the inspection VPC."
  value       = aws_vpc.this.cidr_block
}
output "transit_subnet_az_0" {
  description = "The CIDR block for the transit subnet in AZ A."
  value       = aws_subnet.transit_subnet_az_0.cidr_block
}
output "appliance_subnet_az_0" {
  description = "The CIDR block for the appliance subnet in AZ A."
  value       = aws_subnet.appliance_subnet_az_0.cidr_block
}
output "public_subnet_az_0" {
  description = "The CIDR block for the public subnet in AZ A."
  value       = aws_subnet.public_subnet_az_0.cidr_block
}
output "transit_subnet_az_1" {
  description = "The CIDR block for the transit subnet in AZ B."
  value       = aws_subnet.transit_subnet_az_1.cidr_block
}
output "appliance_subnet_az_1" {
  description = "The CIDR block for the appliance subnet in AZ B."
  value       = aws_subnet.appliance_subnet_az_1.cidr_block
}
output "public_subnet_az_1" {
  description = "The CIDR block for the public subnet in AZ B."
  value       = aws_subnet.public_subnet_az_1.cidr_block
}