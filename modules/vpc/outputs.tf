output "vpc_id" {
  value = aws_vpc.ilios_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.ilios-public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.ilios-private[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.ilios_igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.ilios_nat_gw.id
}