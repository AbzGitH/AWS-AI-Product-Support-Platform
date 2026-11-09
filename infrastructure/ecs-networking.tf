# Provide internet connectivity for ECS/Fargate tasks.
resource "aws_internet_gateway" "ecs" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "${var.app_name}-${var.environment}-ecs-igw"
  }
}

# Keep public routing separate from the VPC's main route table.
resource "aws_route_table" "ecs_public" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "${var.app_name}-${var.environment}-ecs-public-rt"
  }
}

# Route outbound internet traffic through the Internet Gateway.
resource "aws_route" "ecs_internet" {
  route_table_id         = aws_route_table.ecs_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ecs.id
}

# Associate both application subnets with the new route table.
resource "aws_route_table_association" "ecs_a" {
  subnet_id      = aws_subnet.app_a.id
  route_table_id = aws_route_table.ecs_public.id
}

resource "aws_route_table_association" "ecs_b" {
  subnet_id      = aws_subnet.app_b.id
  route_table_id = aws_route_table.ecs_public.id
}
