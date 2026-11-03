output "vpc_id" {
  description = "Application VPC ID"
  value       = aws_vpc.app.id
}

output "subnet_ids" {
  description = "Application subnet IDs across two Availability Zones"
  value = [
    aws_subnet.app_a.id,
    aws_subnet.app_b.id
  ]
}

output "subnet_availability_zones" {
  description = "Availability Zones used by application subnets"
  value = [
    aws_subnet.app_a.availability_zone,
    aws_subnet.app_b.availability_zone
  ]
}
