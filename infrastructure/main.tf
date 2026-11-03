# Dedicated application network
resource "aws_vpc" "app" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.app_name}-${var.environment}-vpc"
    Environment = var.environment
  }
}

# First subnet in London Availability Zone A
resource "aws_subnet" "app_a" {
  vpc_id            = aws_vpc.app.id
  cidr_block        = "10.20.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "${var.app_name}-${var.environment}-subnet-a"
  }
}

# Second subnet in London Availability Zone B
resource "aws_subnet" "app_b" {
  vpc_id            = aws_vpc.app.id
  cidr_block        = "10.20.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "${var.app_name}-${var.environment}-subnet-b"
  }
}
