"""AWS Lambda handler for Fit & Recover product support."""

import json
import os
from uuid import uuid4
from datetime import datetime, timezone


def lambda_handler(event, context):
    """Process a customer support request and return an HTTP response."""

    # API Gateway sends the request body as a JSON string.
    body = event.get("body") or "{}"

    try:
        request = json.loads(body) if isinstance(body, str) else body
    except (json.JSONDecodeError, TypeError):
        return {
            "statusCode": 400,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": "Invalid JSON request"}),
        }

    # Validate the customer's question before processing it.
    if not isinstance(request, dict):
        return {
            "statusCode": 400,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": "JSON body must be an object"}),
        }

    question = request.get("question")

    if not isinstance(question, str) or not question.strip():
        return {
            "statusCode": 400,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": "A product question is required"}),
        }

    # Store the validated enquiry with a unique reference.
    import boto3
    from botocore.exceptions import BotoCoreError, ClientError

    table_name = os.environ.get("SUPPORT_TABLE_NAME")
    if not table_name:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Database not configured"}),
        }

    request_id = str(uuid4())
    record = {
        "requestId": request_id,
        "question": question.strip(),
        "createdAt": datetime.now(timezone.utc).isoformat(),
        "status": "received",
    }

    try:
        table = boto3.resource("dynamodb").Table(table_name)
        table.put_item(Item=record)
    except (BotoCoreError, ClientError):
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Unable to save request"}),
        }

    # AI-generated responses will be added in Lesson 6.
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({
            "status": "received",
            "requestId": request_id,
            "message": "Your product support request has been saved.",
        }),
    }
