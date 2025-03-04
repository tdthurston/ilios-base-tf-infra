output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.ilios_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets in the EKS cluster"
  value       = aws_subnet.ilios_public[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets in the EKS cluster"
  value       = aws_subnet.ilios_private[*].id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.ilios_igw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT gateway"
  value       = aws_nat_gateway.ilios_nat_gw.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.ilios_vpc.cidr_block
}