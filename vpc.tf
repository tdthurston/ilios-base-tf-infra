module "ilios_vpc" {

  source             = "./modules/vpc"
  
  vpc_cidr_block     = var.vpc_cidr_block
  vpc_name           = var.vpc_name
  subnet_cidr_blocks = var.subnet_cidr_blocks
  azs                = var.azs

}

output "aws_region" {
  description = "The AWS region to create resources in"
  value = var.aws_region
}
output "vpc_id" {
  description = "The ID of the VPC"
  value = module.ilios_vpc.vpc_id
}
output "public_subnet_ids" {
  description = "The IDs of the public subnets in the EKS cluster"
  value = module.ilios_vpc.public_subnet_ids
}
output "private_subnet_ids" {
  description = "The IDs of the private subnets in the EKS cluster"
  value = module.ilios_vpc.private_subnet_ids
}
output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value = module.ilios_vpc.internet_gateway_id
}
output "nat_gateway_id" {
  description = "The ID of the NAT gateway"
  value = module.ilios_vpc.nat_gateway_id
}
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value = module.ilios_vpc.vpc_cidr_block
}