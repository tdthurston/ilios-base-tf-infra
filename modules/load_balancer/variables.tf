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

variable "public_subnet_ids" {
  description = "The IDs of the public subnets in which to create the EKS cluster"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "instance_type" {
  description = "The instance type of the load balancer"
  type        = string
}

variable "instance_name" {
  description = "The name of the load balancer instance"
  type        = string
}