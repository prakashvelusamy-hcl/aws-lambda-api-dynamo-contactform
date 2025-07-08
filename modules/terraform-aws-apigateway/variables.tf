variable "lambda_integration_uri_arn" {
  description = "The ARN of the Lambda function to be integrated with API Gateway as the backend."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  type        = string
}

variable "route_key" {
  description = "The route key for the API Gateway HTTP API (e.g., GET /resource or POST /login)."
  type        = string
}
variable "project_tags" {
  description = "A map of tags for my project"
  type        = map(string) 
}