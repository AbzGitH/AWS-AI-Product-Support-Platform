# Store customer support requests for the Fit & Recover platform.
resource "aws_dynamodb_table" "support_requests" {
  name         = "${var.app_name}-${var.environment}-support-requests"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "requestId"

  # Unique identifier for every customer support request.
  attribute {
    name = "requestId"
    type = "S"
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-support-requests"
    Environment = var.environment
  }
}
