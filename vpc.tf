# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Main VPC"
    Owner= "naga sireesha"
  }
}

# Create Web Public Subnet
resource "aws_subnet" "public_subnet-1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet-1"
    Owner= "naga sireesha"
  }
}

resource "aws_subnet" "public_subnet-2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet-2"
    Owner= "naga sireesha"
  }
}

# Create Application Private Subnet
resource "aws_subnet" "private_subnet-1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet-1"
  }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet-2"
  }
}

# Create Database Private Subnet
resource "aws_subnet" "database-subnet-1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Database-1"
  }
}

resource "aws_subnet" "database-subnet-2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Database-2"
  }

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet_Gateway"
  }
}


resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main_vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route_table"
  }
}

# Create private Subnet association with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.rt.id
}}
