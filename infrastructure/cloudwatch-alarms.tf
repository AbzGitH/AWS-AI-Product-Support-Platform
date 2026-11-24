resource "aws_cloudwatch_metric_alarm" "support_api_errors" {
  alarm_name          = "ai-product-support-dev-support-api-errors"
  alarm_description   = "Detect errors in the product support Lambda API."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "notBreaching"
  actions_enabled     = false

  dimensions = {
    FunctionName = aws_lambda_function.support_api.function_name
  }

  tags = {
    Project     = var.app_name
    Environment = var.environment
  }
}
