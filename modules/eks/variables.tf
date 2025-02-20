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