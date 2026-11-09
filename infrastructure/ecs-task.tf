# Reuse the verified ECS task execution role.
data "aws_iam_role" "ecs_execution" {
  name = "ecsTaskExecutionRole"
}

# Define the catalogue container for AWS Fargate.
resource "aws_ecs_task_definition" "catalogue" {
  family                   = "fit-recover-catalogue"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_execution.arn

  # Match the ARM64 image built on Apple Silicon.
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  # Describe the application and its CloudWatch logging.
  container_definitions = jsonencode([
    {
      name      = "fit-recover-catalogue"
      image     = "560396669076.dkr.ecr.eu-west-2.amazonaws.com/fit-recover-catalogue:v1"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.catalogue.name
          awslogs-region        = "eu-west-2"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "fit-recover-catalogue"
  }
}
