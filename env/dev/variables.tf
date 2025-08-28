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

