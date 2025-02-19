variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of desired availability zones"
  type        = list(string)
}

/*
terraform apply \
  -var="vpc_cidr_block=10.0.0.0/16" \
  -var="vpc_name=ilios-vpc" \
  -var='subnet_cidr_blocks=["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]' \
  -var='azs=["us-east-1a", "us-east-1b"]'
*/