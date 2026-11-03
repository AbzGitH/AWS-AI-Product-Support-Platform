variable "aws_region" {
  description = "AWS region for infrastructure"
  type        = string
  default     = "eu-west-2"
}

variable "app_name" {
  description = "Application name used in AWS resource naming"
  type        = string
  default     = "ai-product-support"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
