resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "subnet_route_1" {
  subnet_id      = aws_subnet.subnet_public_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_route_2" {
  subnet_id      = aws_subnet.subnet_public_2.id
  route_table_id = aws_route_table.route_table.id
}
