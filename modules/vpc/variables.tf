variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "The CIDR blocks for the subnet"
  type        = list(string)
}

variable "azs" {
  description = "List of desired availability zones for the subnet"
  type        = list(string)
}