variable "aws_region" {
  description = "The AWS region where the infrastructure will be deployed (e.g., ap-south-1)."
  type        = string
}

variable "route_key" {
  description = "The route key for the API Gateway HTTP API, typically in the format 'METHOD /path' (e.g., 'GET /users')."
  type        = string
}
variable "aws_lambda_function_name" {
    description = "The lambda function name"
    type = string
}

variable "project_tags" {
  description = "A map of tags to assign to the Lambda function."
  type        = map(string)
}
variable "dynamodb_name" {
    description = "The Dynamo DB table name"
    type = string
} 
variable "dynamodb_billing_mode" {
    description = "The Dynamo DB billing mode"
    type = string
}
