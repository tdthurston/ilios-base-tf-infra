resource "aws_vpc" "ilios_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "ilios-public" {
  count = length(var.azs)

  vpc_id                  = aws_vpc.ilios_vpc.id
  cidr_block              = var.subnet_cidr_blocks[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "ilios-private" {
  count = length(var.azs)

  vpc_id                  = aws_vpc.ilios_vpc.id
  cidr_block              = var.subnet_cidr_blocks[count.index + 2]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "ilios_igw" {
  vpc_id = aws_vpc.ilios_vpc.id

  tags = {
    Name = "ilios-igw"
  }
}

resource "aws_eip" "ilios_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ilios_nat_gw" {
  allocation_id = aws_eip.ilios_eip.id
  subnet_id     = aws_subnet.ilios-public[0].id

  tags = {
    Name = "ilios-nat-gw"
  }

  depends_on = [aws_internet_gateway.ilios_igw]
}

resource "aws_route_table" "ilios_public_rt" {
  vpc_id = aws_vpc.ilios_vpc.id

  tags = {
    Name = "ilios-public-rt"
  }
}

resource "aws_route" "ilios_public_route" {
  route_table_id         = aws_route_table.ilios_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ilios_igw.id

}

resource "aws_route_table_association" "ilios_public_sa" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.ilios-public[count.index].id
  route_table_id = aws_route_table.ilios_public_rt.id
}

resource "aws_route_table" "ilios_private_rt" {
  vpc_id = aws_vpc.ilios_vpc.id

  tags = {
    Name = "ilios-private-rt"
  }
}

resource "aws_route" "ilios_private_route" {

  route_table_id         = aws_route_table.ilios_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ilios_nat_gw.id


}

resource "aws_route_table_association" "ilios_private_sa" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.ilios-private[count.index].id
  route_table_id = aws_route_table.ilios_private_rt.id

}
