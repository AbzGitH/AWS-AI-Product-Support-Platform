# Public HTTP API entry point for Fit & Recover support.
resource "aws_apigatewayv2_api" "support" {
  name          = "${var.app_name}-${var.environment}-support-api"
  protocol_type = "HTTP"

  # Restrict cross-origin browser requests to the deployed frontend.
  cors_configuration {
    allow_origins = ["https://d3cbdfekpp2u2v.cloudfront.net"]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["content-type"]
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-support-api"
  }
}
