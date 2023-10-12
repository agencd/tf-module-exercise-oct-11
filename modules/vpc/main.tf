resource "aws_vpc" "bambam" {
  cidr_block = var.vpc_cidr 
}

variable "vpc_cidr" {
  type = string
}

output "vpc_id" {
  value = aws_vpc.bambam.id
}

