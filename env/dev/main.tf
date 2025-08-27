terraform {
  required_version = ">= 1.1.0"
  cloud {
    organization = "opticore"
    workspaces {
      name = "tfp-net-inspection-dev"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-2"
  profile = "aws-tgw-paloalto"
}

data "aws_region" "current" {}
