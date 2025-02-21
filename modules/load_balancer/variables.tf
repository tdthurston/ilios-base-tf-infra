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

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}