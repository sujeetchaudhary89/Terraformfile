## Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/26"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "main"
  }
}

## Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.0.16/28"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags {
    Name = "main-public-2"
  }
}

#resource "aws_subnet" "main-public-3" {
#  vpc_id                  = "${aws_vpc.main.id}"
#  cidr_block              = "10.0.3.0/24"
#  map_public_ip_on_launch = "true"
#  availability_zone       = "us-west-2c"
#
#  tags {
#    Name = "main-public-3"
#  }
#}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.0.32/28"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.0.48/28"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1d"

  tags {
    Name = "main-private-2"
  }
}

#resource "aws_subnet" "main-private-3" {
#  vpc_id                  = "${aws_vpc.main.id}"
#  cidr_block              = "10.0.6.0/24"
#  map_public_ip_on_launch = "false"
#  availability_zone       = "us-west-2c"
#
#  tags {
#    Name = "main-private-3"
#  }
#}

## Internet Gateway
resource "aws_internet_gateway" "main-igateway" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main-igateway"
  }
}

## Route Tables
resource "aws_route_table" "main-public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-igateway.id}"
  }

  tags {
    Name = "main-public-1"
  }
}

## Route Table Associations Public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = "${aws_subnet.main-public-1.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = "${aws_subnet.main-public-2.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}

#resource "aws_route_table_association" "main-public-3-a" {
#  subnet_id      = "${aws_subnet.main-public-3.id}"
#  route_table_id = "${aws_route_table.main-public.id}"
#}
