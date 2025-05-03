##terraform {
  #required_providers {
    #aws = {
      #source  = "hashicorp/aws"
     # version = "~> 5.0"
    #}
  ##}
##}

provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}