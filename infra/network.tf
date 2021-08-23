resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "awslab-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_public_cidr
  availability_zone = var.aws_az

  tags = {
    Name = "awslab-subnet-public"
  }
}

resource "aws_internet_gateway" "aws_lab_IGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "awslab-internet-gateway"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "awslab-route-table-public"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_RT.id
  destination_cidr_block = var.public_dest_cidr_block
  gateway_id             = aws_internet_gateway.aws_lab_IGW.id

}

resource "aws_route_table_association" "route_public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_RT.id
}