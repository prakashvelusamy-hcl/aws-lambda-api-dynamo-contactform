aws_region = "ap-south-1"
route_key = "contact"
aws_lambda_function_name = "contact_form_lambda"
project_tags = {
  Environment = "dev"
  Project     = "contact_form_lambda"
  Owner       = "dev-team"
}
dynamodb_name = "contact_dynamo_db"
dynamodb_billing_mode = "PROVISIONED" 