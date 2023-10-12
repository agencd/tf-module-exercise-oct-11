terraform {
  cloud {
    organization = "024_2023-summer-cloud"

    workspaces {
      name = "infra-vpc"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "subnets" {
  type = map(object({
    cidr_block = string
  }))
  default = {}
}

variable "vpc_cidr" {
  type = string
}

module "vpc" {
  source   = "./modules/vpc/"
  vpc_cidr = "10.0.0.0/16" #var.vpc_cidr
}

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

module "subnets" {
  source = "./modules/subnet/"
  vpc_id = module.vpc.vpc_id
  subnets = {
    my_first_subnet_using_module = {
        cidr_block = "10.0.1.0/24"
        availability_zone = "us-east-1c"
    }
    my-demo2-subnet = {
        cidr_block = "10.0.2.0/24"
        availability_zone = "us-east-1a"
    }
    my-demo3-subnet = {
        cidr_block = "10.0.3.0/24"
        availability_zone = "us-east-1b"
    }
  }
}