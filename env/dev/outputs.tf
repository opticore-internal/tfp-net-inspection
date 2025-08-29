output "vpc_cidr_block" {
  description = "Inspection VPC CIDR"
  value       = module.dev-inspection.vpc_cidr_block
}
output "transit_subnet_az_0" {
  description = "The CIDR block for the transit subnet in AZ A."
  value       = module.dev-inspection.transit_subnet_az_0
}
output "az_a" {
  description = "CIDR block for AZ index 0 (local.az_a)"
  value       = module.dev-inspection.az_a
}
output "az_b" {
  description = "CIDR block for AZ index 1 (local.az_b)"
  value       = module.dev-inspection.az_b
}
output "transit_subnet_az_1" {
  description = "Transit subnet CIDR (AZ 1)"
  value       = module.dev-inspection.transit_subnet_az_1
}
output "gwlbe_subnet_az_0" {
  description = "GWLBe subnet CIDR (AZ 0)"
  value       = module.dev-inspection.gwlbe_subnet_az_0
}
output "gwlbe_subnet_az_1" {
  description = "GWLBe subnet CIDR (AZ 1)"
  value       = module.dev-inspection.gwlbe_subnet_az_1
}
output "gwlb_subnet_az_0" {
  description = "GWLB subnet CIDR (AZ 0)"
  value       = module.dev-inspection.gwlb_subnet_az_0
}
output "gwlb_subnet_az_1" {
  description = "GWLB subnet CIDR (AZ 1)"
  value       = module.dev-inspection.gwlb_subnet_az_1
}
output "appliance_subnet_az_0" {
  description = "Appliance subnet CIDR (AZ 0)"
  value       = module.dev-inspection.appliance_subnet_az_0
}
output "appliance_subnet_az_1" {
  description = "Appliance subnet CIDR (AZ 1)"
  value       = module.dev-inspection.appliance_subnet_az_1
}
output "public_subnet_az_0" {
  description = "Public subnet CIDR (AZ 0)"
  value       = module.dev-inspection.public_subnet_az_0
}
output "public_subnet_az_1" {
  description = "Public subnet CIDR (AZ 1)"
  value       = module.dev-inspection.public_subnet_az_1
}
output "mgmt_subnet_az_0" {
  description = "Mgmt subnet CIDR (AZ 0)"
  value       = module.dev-inspection.mgmt_subnet_az_0
}
output "mgmt_subnet_az_1" {
  description = "Mgmt subnet CIDR (AZ 1)"
  value       = module.dev-inspection.mgmt_subnet_az_1
}


output "pafw1_mgmt_eip_address" {
  description = "PAN1 mgmt EIP (if deployed)"
  value       = module.dev-inspection.pafw1_mgmt_eip_address
}
output "pafw2_mgmt_eip_address" {
  description = "PAN2 mgmt EIP (if deployed)"
  value       = module.dev-inspection.pafw2_mgmt_eip_address
}


output "redis_primary_endpoint" {
  description = "Redis primary endpoint (if deployed)"
  value       = module.dev-inspection.redis_primary_endpoint
}
output "bootstrap_s3_bucket" {
  description = "PAN bootstrap S3 bucket (if deployed)"
  value       = module.dev-inspection.bootstrap_s3_bucket
}

output "bootstrap_init_cfg_s3_key" {
  description = "init-cfg.txt S3 key (if deployed)"
  value       = module.dev-inspection.bootstrap_init_cfg_s3_key
}

output "pafw1_mgmt_private_ip" {
  description = "PAN1 mgmt private IP (if deployed)"
  value       = module.dev-inspection.pafw1_mgmt_private_ip
}

output "pafw2_mgmt_private_ip" {
  description = "PAN2 mgmt private IP (if deployed)"
  value       = module.dev-inspection.pafw2_mgmt_private_ip
}
