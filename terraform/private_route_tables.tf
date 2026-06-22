resource "aws_route_table" "private_app" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.main.id

  }

  tags = {

    Name = "${var.project_name}-private-app-rt"

  }

}

resource "aws_route_table_association" "private_app_a" {

  subnet_id = aws_subnet.private_app_a.id

  route_table_id = aws_route_table.private_app.id

}

resource "aws_route_table_association" "private_app_b" {

  subnet_id = aws_subnet.private_app_b.id

  route_table_id = aws_route_table.private_app.id

}