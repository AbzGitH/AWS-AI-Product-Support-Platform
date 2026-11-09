# Dedicated firewall for the Fit & Recover catalogue API.
resource "aws_security_group" "ecs_catalogue" {
  name        = "${var.app_name}-${var.environment}-catalogue-sg"
  description = "Security group for ECS catalogue tasks"
  vpc_id      = aws_vpc.app.id

  # No inbound access until a restricted testing rule is approved.
  tags = {
    Name = "${var.app_name}-${var.environment}-catalogue-sg"
  }
}

# Allow HTTPS access to AWS services such as ECR and CloudWatch.
resource "aws_vpc_security_group_egress_rule" "ecs_https" {
  security_group_id = aws_security_group.ecs_catalogue.id
  description       = "Outbound HTTPS for AWS services"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}
