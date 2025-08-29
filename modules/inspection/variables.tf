variable "env" {
  description = "The environment for which the inspection module is being configured."
  type        = string  
}
variable "vpc_region" {
  description = "The AWS region where the VPC is located."
  type        = string
}
variable "vpc_region_shortname" {
  description = "Short names for the AWS regions."
  type        = map(string)
  default     = {
    "eu-west-2" = "euw2"
  }
}

variable "vpc_az_list" {
  description = "Availability zones used by the VPC (index 0/1)."
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "vpc_az_shortname" {
  description = "Short names for the availability zones used in the VPC."
  type        = map(string)
  default     = {
    "eu-west-2a" = "euw2a"
    "eu-west-2b" = "euw2b"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block for the inspection VPC."
  type        = string
}

variable "amazon_side_asn" {
  description = "Amazon side ASN for the Transit Gateway."
  type        = number
  default     = 64513
}

variable "tags" {
  description = "Additional tags to merge into all resources. Name is set by the module."
  type        = map(string)
  default     = {}
}

# PAN deployment toggles and parameters
variable "deploy_pan" {
  description = "Whether to deploy Palo Alto firewalls, IAM, SGs, EIPs, Redis, and bootstrap S3."
  type        = bool
  default     = false
}

variable "pan_ami" {
  description = "AMI ID for Palo Alto VM-Series."
  type        = string
  default     = "ami-00440da0b68785420"
}

variable "pan_instance_type" {
  description = "Instance type for Palo Alto VM-Series."
  type        = string
  default     = "m5.large"
}

variable "pan_key_name" {
  description = "EC2 key pair name for PAN instances."
  type        = string
  default     = "aws-tgw-paloalto-key"
}


variable "bootstrap_bucket_name" {
  description = "S3 bucket name for PAN bootstrap files (must be globally unique)."
  type        = string
  default     = "pafw-bootstrap-bucket"
}

variable "redis_auth_token" {
  description = "Auth token for Redis used by PAN bootstrap."
  type        = string
  sensitive   = true
  default     = ""
}

variable "redis_port" {
  description = "Redis port."
  type        = number
  default     = 6379
}


# Spoke VPCs, TGW attachments, and test instances
variable "deploy_spokes" {
  description = "Whether to deploy Spoke VPCs, TGW attachments, and test instances."
  type        = bool
  default     = false
}

variable "spoke1_cidr" {
  description = "CIDR for Spoke 1 VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "spoke2_cidr" {
  description = "CIDR for Spoke 2 VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "spoke_subnet_mask" {
  description = "Subnet mask size for test subnets"
  type        = number
  default     = 28
}

variable "test_instance_type" {
  description = "Instance type for test instances"
  type        = string
  default     = "t3.micro"
}

variable "test_key_name" {
  description = "Key pair name for test instances"
  type        = string
  default     = "aws-tgw-paloalto-key"
}

variable "spoke1_target_port" {
  type        = number
  description = "Additional SSH port to test on the instance"
  default     = 2221
}

variable "spoke2_target_port" {
  type        = number
  description = "Additional SSH port to test on the instance"
  default     = 2222
}


# Inbound NLB and demo flows
variable "deploy_nlb" {
  description = "Whether to deploy the inbound NLB and demo flows. Requires deploy_spokes = true."
  type        = bool
  default     = false
}
