output "vpc_cidr_block" {
  description = "The CIDR block for the inspection VPC."
  value       = aws_vpc.this.cidr_block
}
output "transit_subnet_az_0" {
  description = "The CIDR block for the transit subnet in AZ A."
  value       = aws_subnet.transit_subnet_az_0.cidr_block
}
output "transit_subnet_az_1" {
  description = "The CIDR block for the transit subnet in AZ B."
  value       = aws_subnet.transit_subnet_az_1.cidr_block
}

output "gwlbe_subnet_az_0" {
  description = "The CIDR block for the public subnet in AZ A."
  value       = aws_subnet.public_subnet_az_0.cidr_block
}
output "gwlbe_subnet_az_1" {
  description = "The CIDR block for the public subnet in AZ B."
  value       = aws_subnet.public_subnet_az_0.cidr_block
}
output "gwlb_subnet_az_0" {
  description = "The CIDR block for the public subnet in AZ A."
  value       = aws_subnet.public_subnet_az_0.cidr_block
}
output "gwlb_subnet_az_1" {
  description = "The CIDR block for the public subnet in AZ B."
  value       = aws_subnet.public_subnet_az_0.cidr_block
}
output "appliance_subnet_az_0" {
  description = "The CIDR block for the appliance subnet in AZ A."
  value       = aws_subnet.appliance_subnet_az_0.cidr_block
}
output "appliance_subnet_az_1" {
  description = "The CIDR block for the appliance subnet in AZ B."
  value       = aws_subnet.appliance_subnet_az_1.cidr_block
}
output "public_subnet_az_0" {
  description = "The CIDR block for the public subnet in AZ A."
  value       = aws_subnet.public_subnet_az_0.cidr_block
}
output "public_subnet_az_1" {
  description = "The CIDR block for the public subnet in AZ B."
  value       = aws_subnet.public_subnet_az_1.cidr_block
}
output "mgmt_subnet_az_0" {
  description = "The CIDR block for the management subnet in AZ A."
  value       = aws_subnet.mgmt_subnet_az_0.cidr_block
}
output "mgmt_subnet_az_1" {
  description = "The CIDR block for the management subnet in AZ B."
  value       = aws_subnet.mgmt_subnet_az_1.cidr_block
}







# Optional PAN outputs
output "pafw1_mgmt_eip_address" {
  description = "The public IP assigned to the PAN1 management interface"
  value       = try(aws_eip.pafw1_mgmt_eip[0].public_ip, null)
}
output "pafw2_mgmt_eip_address" {
  description = "The public IP assigned to the PAN2 management interface"
  value       = try(aws_eip.pafw2_mgmt_eip[0].public_ip, null)
}

output "redis_primary_endpoint" {
  description = "Redis primary endpoint address"
  value       = try(aws_elasticache_replication_group.pafw_redis[0].primary_endpoint_address, null)
}

output "bootstrap_s3_bucket" {
  description = "S3 bucket for Palo Alto bootstrap files"
  value       = try(aws_s3_bucket.pan_bootstrap[0].bucket, null)
}

output "bootstrap_init_cfg_s3_key" {
  description = "S3 object key for init-cfg.txt"
  value       = try(aws_s3_object.init_cfg[0].key, null)
}
