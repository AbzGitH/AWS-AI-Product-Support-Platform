# Deploy the Fit & Recover customer support Lambda function.
resource "aws_lambda_function" "support_api" {
  function_name = "${var.app_name}-${var.environment}-support-api"
  role          = aws_iam_role.support_lambda.arn
  runtime       = "python3.13"
  handler       = "handler.lambda_handler"

  # Package the verified Python application.
  filename         = "${path.module}/../build/support-lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/../build/support-lambda.zip")

  timeout     = 10
  memory_size = 128

  # Tell Lambda which DynamoDB table stores customer enquiries.
  environment {
    variables = {
      SUPPORT_TABLE_NAME = aws_dynamodb_table.support_requests.name
    }
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-support-api"
  }
}
