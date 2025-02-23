module "ilios_vpc" {

  source             = "./modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  vpc_name           = var.vpc_name
  subnet_cidr_blocks = var.subnet_cidr_blocks
  azs                = var.azs

}

output "vpc_id" {
  value = module.ilios_vpc.vpc_id
}
output "public_subnet_ids" {
  value = module.ilios_vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.ilios_vpc.private_subnet_ids
}
output "internet_gateway_id" {
  value = module.ilios_vpc.internet_gateway_id
}
output "nat_gateway_id" {
  value = module.ilios_vpc.nat_gateway_id
}
output "vpc_cidr_block" {
  value = module.ilios_vpc.vpc_cidr_block
}