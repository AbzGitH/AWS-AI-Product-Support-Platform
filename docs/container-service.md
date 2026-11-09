# Containerised Service — Product Catalogue API

## Business Purpose
Provide a reusable product catalogue service for the
Fit & Recover fitness and recovery store.

## Responsibilities
- Serve product information through HTTP endpoints.
- Provide product IDs, names, descriptions and prices.
- Support the customer-facing website.
- Allow future expansion without rebuilding the frontend.

## Initial Products
- Home Workout Starter Kit — £59.99
- Yoga & Mobility Kit — £44.99
- Training & Recovery Bundle — £79.99

## Technology
- Python with Flask for the API.
- Docker for application packaging.
- Amazon ECR for storing the container image.
- Amazon ECS with AWS Fargate for deployment.
- Amazon CloudWatch for application logs.

## Planned Endpoints
- GET /health — Application health check.
- GET /products — List all products.
- GET /products/<id> — Retrieve one product.

## Architecture
Frontend (S3 + CloudFront)
  → Product Catalogue API (ECS/Fargate)
  → Product information (initially stored in application code)

AI support will be implemented separately using
API Gateway, Lambda and Amazon Bedrock.

## Security and Cost
- No database required for the initial catalogue.
- Avoid unnecessary NAT Gateway costs.
- Review networking and public access before deployment.
- Verify AWS costs before provisioning ECS resources.
