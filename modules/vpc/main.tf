resource "aws_vpc" "ilios_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    {
      Name = var.vpc_name
    },
    var.tags
  )
}

resource "aws_subnet" "ilios_public" {
  count = 2

  vpc_id                  = aws_vpc.ilios_vpc.id
  cidr_block              = element(var.subnet_cidr_blocks, count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "public-subnet-${count.index + 1}"
    },
    var.tags
  )
}

resource "aws_subnet" "ilios_private" {
  count = 2

  vpc_id                  = aws_vpc.ilios_vpc.id
  cidr_block              = element(var.subnet_cidr_blocks, count.index + 2)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "private-subnet-${count.index + 1}"
    },
    var.tags
  )
}

resource "aws_internet_gateway" "ilios_igw" {
  vpc_id = aws_vpc.ilios_vpc.id

  tags = merge(
    {
      Name = "ilios-igw"
    },
    var.tags
  )
}

resource "aws_eip" "ilios_eip" {
  domain = "vpc"
  tags   = var.tags
}

resource "aws_nat_gateway" "ilios_nat_gw" {
  allocation_id = aws_eip.ilios_eip.id
  subnet_id     = aws_subnet.ilios_public[0].id

  tags = merge(
    {
      Name = "ilios-nat-gw"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.ilios_igw]
}

resource "aws_route_table" "ilios_public_rt" {
  vpc_id = aws_vpc.ilios_vpc.id

  tags = merge(
    {
      Name = "ilios-public-rt"
    },
    var.tags
  )
}

resource "aws_route" "ilios_public_route" {
  route_table_id         = aws_route_table.ilios_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ilios_igw.id

}

resource "aws_route_table_association" "ilios_public_sa" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.ilios_public[count.index].id
  route_table_id = aws_route_table.ilios_public_rt.id
}

resource "aws_route_table" "ilios_private_rt" {
  vpc_id = aws_vpc.ilios_vpc.id

  tags = merge(
    {
      Name = "ilios-private-rt"
    },
    var.tags
  )
}

resource "aws_route" "ilios_private_route" {

  route_table_id         = aws_route_table.ilios_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ilios_nat_gw.id


}

resource "aws_route_table_association" "ilios_private_sa" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.ilios_private[count.index].id
  route_table_id = aws_route_table.ilios_private_rt.id

}
