# Private storage for the Fit & Recover frontend
resource "aws_s3_bucket" "frontend" {
  bucket = "fit-recover-web-560396669076"

  tags = {
    Name        = "${var.app_name}-${var.environment}-frontend"
    Environment = var.environment
  }
}

# Prevent public access to the bucket
resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Encrypt stored website files
resource "aws_s3_bucket_server_side_encryption_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
