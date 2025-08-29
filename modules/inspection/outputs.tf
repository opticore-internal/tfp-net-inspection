output "vpc_cidr_block" {
  description = "CIDR block for the inspection VPC."
  value       = aws_vpc.this.cidr_block
}

# Subnets AZ 0
output "transit_subnet_az_0" {
  description = "CIDR for the transit subnet in AZ A."
  value       = aws_subnet.transit_subnet_az_0.cidr_block
}
output "gwlbe_subnet_az_0" {
  description = "CIDR for the GWLBE subnet in AZ A."
  value       = aws_subnet.gwlbe_subnet_az_0.cidr_block
}
output "gwlb_subnet_az_0" {
  description = "CIDR for the GWLB subnet in AZ A."
  value       = aws_subnet.gwlb_subnet_az_0.cidr_block
}
output "appliance_subnet_az_0" {
  description = "CIDR for the appliance subnet in AZ A."
  value       = aws_subnet.appliance_subnet_az_0.cidr_block
}
output "public_subnet_az_0" {
  description = "CIDR for the public subnet in AZ A."
  value       = aws_subnet.public_subnet_az_0.cidr_block
}
output "mgmt_subnet_az_0" {
  description = "CIDR for the management subnet in AZ A."
  value       = aws_subnet.mgmt_subnet_az_0.cidr_block
}

# Subnets AZ 1
output "transit_subnet_az_1" {
  description = "CIDR for the transit subnet in AZ B."
  value       = aws_subnet.transit_subnet_az_1.cidr_block
}
output "gwlbe_subnet_az_1" {
  description = "CIDR for the GWLBE subnet in AZ B."
  value       = aws_subnet.gwlbe_subnet_az_1.cidr_block
}
output "gwlb_subnet_az_1" {
  description = "CIDR for the GWLB subnet in AZ B."
  value       = aws_subnet.gwlb_subnet_az_1.cidr_block
}
output "appliance_subnet_az_1" {
  description = "CIDR for the appliance subnet in AZ B."
  value       = aws_subnet.appliance_subnet_az_1.cidr_block
}
output "public_subnet_az_1" {
  description = "CIDR for the public subnet in AZ B."
  value       = aws_subnet.public_subnet_az_1.cidr_block
}
output "mgmt_subnet_az_1" {
  description = "CIDR for the management subnet in AZ B."
  value       = aws_subnet.mgmt_subnet_az_1.cidr_block
}

# Optional PAN outputs
output "pafw1_mgmt_eip_address" {
  description = "Public IP for PAN1 management interface."
  value       = try(aws_eip.pafw1_mgmt_eip[0].public_ip, null)
}
output "pafw2_mgmt_eip_address" {
  description = "Public IP for PAN2 management interface."
  value       = try(aws_eip.pafw2_mgmt_eip[0].public_ip, null)
}

output "redis_primary_endpoint" {
  description = "Redis primary endpoint address."
  value       = try(aws_elasticache_replication_group.pafw_redis[0].primary_endpoint_address, null)
}

output "bootstrap_s3_bucket" {
  description = "S3 bucket for Palo Alto bootstrap files."
  value       = try(aws_s3_bucket.pan_bootstrap[0].bucket, null)
}

output "bootstrap_init_cfg_s3_key" {
  description = "S3 object key for init-cfg.txt."
  value       = try(aws_s3_object.init_cfg[0].key, null)
}

# NLB outputs (for external flow modules)
output "nlb_arn" {
  description = "ARN of the inbound NLB (if created)"
  value       = try(aws_lb.nlb[0].arn, null)
}

output "nlb_dns_name" {
  description = "DNS name of the inbound NLB (if created)"
  value       = try(aws_lb.nlb[0].dns_name, null)
}

output "nlb_sg_id" {
  description = "Security group ID attached to the NLB (if created)"
  value       = try(aws_security_group.nlb_sg[0].id, null)
}

output "vpc_id" {
  description = "VPC ID of the inspection VPC"
  value       = aws_vpc.this.id
}

# Base CIDRs
output "az_a" {
  description = "CIDR block for AZ index 0 (local.az_a)."
  value       = local.az_a
}
output "az_b" {
  description = "CIDR block for AZ index 1 (local.az_b)."
  value       = local.az_b
}

# Palo Alto management ENI private IPs
# Use the singular attribute and splat -> one() so it’s safe with count=0 or 1
output "pafw1_mgmt_private_ip" {
  description = "Private IP of PAN1 management ENI."
  value       = try(one(aws_network_interface.pafw1_mgmt_eni[*].private_ip), null)
}
output "pafw2_mgmt_private_ip" {
  description = "Private IP of PAN2 management ENI."
  value       = try(one(aws_network_interface.pafw2_mgmt_eni[*].private_ip), null)
}

# Spoke test instance outputs (for demo flows)
output "spoke1_instance_private_ip" {
  description = "Private IP of test VM in Spoke 1 (if created)"
  value       = try(aws_instance.test_vm_spoke1[0].private_ip, null)
}

output "spoke1_instance_az" {
  description = "AZ of test VM in Spoke 1 (if created)"
  value       = try(aws_instance.test_vm_spoke1[0].availability_zone, null)
}

output "spoke2_instance_private_ip" {
  description = "Private IP of test VM in Spoke 2 (if created)"
  value       = try(aws_instance.test_vm_spoke2[0].private_ip, null)
}

output "spoke2_instance_az" {
  description = "AZ of test VM in Spoke 2 (if created)"
  value       = try(aws_instance.test_vm_spoke2[0].availability_zone, null)
}
