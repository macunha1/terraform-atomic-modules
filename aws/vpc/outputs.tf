output "id" {
  description = "AWS VPC Id"
  value       = aws_vpc.default.id
}

output "private_subnets" {
  description = "List of private subnets"
  value       = aws_subnet.private.*.id
}

output "private_subnets_azs" {
  description = "List of availability zones being used by private subnets"
  value       = aws_subnet.private.*.availability_zone
}

output "public_subnets" {
  description = "List of public subnets"
  value       = aws_subnet.public.*.id
}

output "public_subnet_azs" {
  description = "List of availability zones being used by public subnets"
  value       = aws_subnet.public.*.availability_zone
}

output "environment" {
  description = "Environment name for this module"
  value       = var.env
}

output "project_name" {
  description = "Project name that this VPC serves"
  value       = var.project_name
}

