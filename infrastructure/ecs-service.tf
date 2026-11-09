# Manage the Fit & Recover catalogue application on AWS Fargate.
resource "aws_ecs_service" "catalogue" {
  name            = "fit-recover-catalogue"
  cluster         = aws_ecs_cluster.catalogue.id
  task_definition = aws_ecs_task_definition.catalogue.arn
  launch_type     = "FARGATE"

  # Keep compute stopped until deployment testing is approved.
  desired_count = 0

  # Allow one task to run with a public IP when activated.
  # The dedicated security group currently blocks all inbound traffic.
  network_configuration {
    subnets = [
      aws_subnet.app_a.id,
      aws_subnet.app_b.id
    ]

    security_groups  = [aws_security_group.ecs_catalogue.id]
    assign_public_ip = true
  }

  tags = {
    Name = "fit-recover-catalogue"
  }
}
