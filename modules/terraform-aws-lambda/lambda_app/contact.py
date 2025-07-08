import os
import json
import boto3
from datetime import datetime

# Initialize AWS clients
dynamodb = boto3.client('dynamodb')
sns = boto3.client('sns')

# DynamoDB table name and SNS Topic ARN from environment variables
DYNAMODB_TABLE = os.environ['DYNAMODB_TABLE']
SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    try:
        # Parse incoming event data (assumes JSON body)
        body = json.loads(event['body'])
        name = body['name']
        email = body['email']
        message = body['message']
        
        # Create a unique ID for the contact submission (e.g., timestamp)
        submission_id = str(datetime.utcnow().isoformat())
        timestamp = str(datetime.utcnow().isoformat())

        # Save to DynamoDB
        dynamodb.put_item(
            TableName=DYNAMODB_TABLE,
            Item={
                'id': {'S': submission_id},
                'timestamp': {'S': timestamp},
                'name': {'S': name},
                'email': {'S': email},
                'message': {'S': message}
            }
        )

        # Send notification to SNS
        sns_message = f"New Contact Form Submission:\n\nName: {name}\nEmail: {email}\nMessage: {message}"
        
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=sns_message,
            Subject="New Contact Form Submission"
        )

        # Return successful response
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Form submitted successfully'})
        }

    except Exception as e:
        # Error handling
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'Failed to submit form', 'details': str(e)})
        }
