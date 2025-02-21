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

# Define load balancer variables

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "lb_arn" {
  description = "The ARN of the load balancer"
}

variable "target_group_arn" {
  description = "The ARN of the target group"
}

variable "listener_arn" {
  description = "The ARN of the listener"
}