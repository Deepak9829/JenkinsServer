resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "myvpc"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "My_IGW"
  }
}


resource "aws_subnet" "mysubnet" {

  
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subnet_cidr
  availability_zone = var.azs
  tags = {
    Name = "Subnet"
  }
}



resource "aws_route_table" "my_RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "myRT"
  }
}


resource "aws_route_table_association" "subnet_ass_to_RT" {
  
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.my_RT.id
}