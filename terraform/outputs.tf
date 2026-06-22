output "vpc_id" {

  value = aws_vpc.main.id

}

output "igw_id" {

  value = aws_internet_gateway.main.id

}

output "nat_eip" {

  value = aws_eip.nat.public_ip

}

output "nat_id" {

  value = aws_nat_gateway.main.id

}