# Keep the public support route disabled between test sessions.
variable "enable_support_route" {
  type    = bool
  default = false
}

# Forward incoming HTTP API requests to our Lambda application.
resource "aws_apigatewayv2_integration" "support_lambda" {
  api_id                 = aws_apigatewayv2_api.support.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.support_api.invoke_arn
  payload_format_version = "2.0"
}

# Customer support requests are sent using POST /support.
resource "aws_apigatewayv2_route" "support" {
  count     = var.enable_support_route ? 1 : 0
  api_id    = aws_apigatewayv2_api.support.id
  route_key = "POST /support"
  target    = "integrations/${aws_apigatewayv2_integration.support_lambda.id}"
}

# Automatically deploy new API routes and integrations.
resource "aws_apigatewayv2_stage" "support" {
  api_id      = aws_apigatewayv2_api.support.id
  name        = "$default"
  auto_deploy = true
}

# Permit this HTTP API to invoke only our support Lambda function.
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowSupportAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.support_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.support.execution_arn}/*/POST/support"
}
