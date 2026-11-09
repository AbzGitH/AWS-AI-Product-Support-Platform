# ECS cluster for the Fit & Recover catalogue application.
resource "aws_ecs_cluster" "catalogue" {
  name = "${var.app_name}-${var.environment}"

  tags = {
    Name = "${var.app_name}-${var.environment}"
  }
}

# Store container logs with limited retention to control costs.
resource "aws_cloudwatch_log_group" "catalogue" {
  name              = "/ecs/fit-recover-catalogue"
  retention_in_days = 7

  tags = {
    Name = "${var.app_name}-${var.environment}-catalogue-logs"
  }
}
