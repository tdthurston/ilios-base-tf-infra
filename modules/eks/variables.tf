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
  description = "The maximum number of nodes that can be unavailable during a rolling update"
  type        = number
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the EKS cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets in which to create the EKS cluster"
  type        = list(string)
}

variable "aws_auth_roles" {
  description = "List of role maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
