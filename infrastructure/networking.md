# Networking Design

Application: ai-product-support
Environment: dev
Region: eu-west-2

## Architecture

- Dedicated application VPC
- Proposed CIDR: 10.20.0.0/16
- Two subnets across separate Availability Zones
- Internet Gateway for public-facing connectivity
- Security groups permitting only required traffic
- ECS/Fargate networking managed within the VPC
- No NAT Gateway unless explicitly required

## Serverless Components

- API Gateway and Lambda do not initially require VPC attachment.
- DynamoDB and Bedrock are accessed through AWS service APIs.

## Cost Control

Review all chargeable networking resources before deployment.
