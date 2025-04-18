# Specify AWS region you would like to create resources in

variable "aws_region" {
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
  description = "The maximum number of nodes that can be unavailable during a rolling update"
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

# Define OIDC variables

variable "github_org" {
  description = "The GitHub organization/username to use for OIDC authentication"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository to use for OIDC authentication"
  type        = string
}

# Define tags

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "ilios"
    ManagedBy   = "terraform"
  }
}