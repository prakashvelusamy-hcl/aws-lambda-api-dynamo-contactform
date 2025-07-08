import os
import json
import boto3
from datetime import datetime

# Initialize AWS clients
dynamodb = boto3.client('dynamodb')
ses = boto3.client('ses')

# DynamoDB table name and SES email configuration from environment variables
DYNAMODB_TABLE = os.environ['DYNAMODB_TABLE']
SENDER_EMAIL = os.environ['SES_SENDER_EMAIL']  # Sender email (SES verified)
RECIPIENT_EMAIL = os.environ['SES_RECIPIENT_EMAIL']  # Recipient email
AWS_REGION = os.environ['SES_REGION']

def lambda_handler(event, context):
    try:
        # Parse incoming event data (assumes JSON body)
        body = json.loads(event['body'])
        name = body['name']
        email = body['email']
        message = body['message']
        
        # Create a unique ID for the contact submission (e.g., timestamp)
        submission_id = str(datetime.utcnow().isoformat())
        
        # Get the current timestamp in Unix format (seconds since the epoch)
        timestamp = int(datetime.utcnow().timestamp())

        # Save to DynamoDB
        dynamodb.put_item(
            TableName=DYNAMODB_TABLE,
            Item={
                'id': {'S': submission_id},
                'timestamp': {'N': str(timestamp)},  # Store timestamp as a number
                'name': {'S': name},
                'email': {'S': email},
                'message': {'S': message}
            }
        )

        # Send notification email using SES
        subject = "New Contact Form Submission"
        email_body = f"New Contact Form Submission:\n\nName: {name}\nEmail: {email}\nMessage: {message}"

        # Send email via SES
        ses.send_email(
            Source=SENDER_EMAIL,
            Destination={
                'ToAddresses': [RECIPIENT_EMAIL]
            },
            Message={
                'Subject': {'Data': subject},
                'Body': {'Text': {'Data': email_body}}
            }
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
