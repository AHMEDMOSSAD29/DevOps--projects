# modules/network/outputs.tf

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC."
}

output "private_subnet_ids" {
  value       = aws_subnet.private.id
  description = "ID of the private subnet."
}
