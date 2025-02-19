resource "aws_vpc" "ilios" {
  cidr_block = var.vpc_cidr_block
    tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "ilios-public" {
  count = 2

  vpc_id     = aws_vpc.ilios-public.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "ilios-private" {
  count = 2

  vpc_id     = aws_vpc.ilios-public.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.az
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}