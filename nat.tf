## NAT Gateway
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.main-public-1.id}"
  depends_on    = ["aws_internet_gateway.main-igateway"]
}

## Route Table for Private Instances
resource "aws_route_table" "main-private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gateway.id}"
  }

  tags {
    Name = "main-private-1"
  }
}

## Route Table Associations Private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = "${aws_subnet.main-private-1.id}"
  route_table_id = "${aws_route_table.main-private.id}"
}

resource "aws_route_table_association" "main-private-1-b" {
  subnet_id      = "${aws_subnet.main-private-2.id}"
  route_table_id = "${aws_route_table.main-private.id}"
}

#resource "aws_route_table_association" "main-private-1-c" {
#  subnet_id      = "${aws_subnet.main-private-3.id}"
#  route_table_id = "${aws_route_table.main-private.id}"
#}
