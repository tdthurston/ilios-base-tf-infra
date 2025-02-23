# Specify AWS region you would like to create resources in

variable "vpc_region" {
  description = "The AWS region to create resources in"
  type        = string
}

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
  description = "Enter a list of two desired availability zones within the selected region."
  type        = list(string)
}

# Define EKS variables

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
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

##  variable "vpc_id" {
##  description = "The ID of the VPC in which to create the EKS cluster"
##  type        = string
##}

##  variable "private_subnet_ids" {
##  description = "The IDs of the private subnets in which to create the EKS cluster"
##  type        = list(string)
##}

# Define load balancer variables

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

##  variable "public_subnet_ids" {
##  description = "The IDs of the public subnets in which to create the EKS cluster"
##  type        = list(string)
##  }