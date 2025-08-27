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
  description = "CIDR block for the inspection VPC."
  type        = list
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