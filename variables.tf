# Define VPC and subnet variables

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

# Define EKS variables

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

variable "cluster_security_group_id" {
  description = "The ID of the security group associated with the EKS cluster"
  type        = string
}

variable "node_group_security_group_id" {
  description = "The ID of the security group associated with the EKS node group"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the EKS node group"
  type        = string
}

variable "desired_capacity" {
  description = "The desired capacity of the EKS node group"
  type        = number
}

variable "min_size" {
  description = "The minimum size of the EKS node group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the EKS node group"
  type        = number
}

variable "max_unavailable" {
  description = "The maximum number of unavailable nodes during a rolling update"
  type        = number
}