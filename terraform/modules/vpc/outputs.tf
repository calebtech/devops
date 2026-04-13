output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet" {
  value = aws_subnet.public[*].id
}

output "private_subnet" {
  value = aws_subnet.private[*].id
}

output "nat_gateway" {
  value = try(aws_nat_gateway.this[0].id, null)
}