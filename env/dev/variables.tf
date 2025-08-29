variable "env" {
  description = "The environment for which the inspection module is being configured."
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the inspection VPC."
  type        = string
  default     = "10.99.8.0/21"
}

variable "amazon_side_asn" {
  description = "ASN for the inspection VPC TGW"
  type        = string
  default     = "64513"
}

variable "deploy_spokes" {
  description = "Deploy demo Spoke VPCs and test instances"
  type        = bool
  default     = true
}

variable "deploy_nlb" {
  description = "Deploy inbound NLB for demo flows"
  type        = bool
  default     = true
}
