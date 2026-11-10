# Allow the AWS Lambda service to assume this execution role.
resource "aws_iam_role" "support_lambda" {
  name = "${var.app_name}-${var.environment}-support-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# Allow Lambda to write operational logs to CloudWatch.
resource "aws_iam_role_policy_attachment" "support_lambda_logs" {
  role       = aws_iam_role.support_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Restrict database permissions to our support requests table.
resource "aws_iam_role_policy" "support_lambda_dynamodb" {
  name = "support-requests-access"
  role = aws_iam_role.support_lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["dynamodb:PutItem", "dynamodb:GetItem"]
      Resource = aws_dynamodb_table.support_requests.arn
    }]
  })
}
