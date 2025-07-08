variable "api_gateway_arn" {
  description = "The ARN of the API Gateway used to grant invoke permissions to the Lambda function."
  type        = string
}
variable "aws_lambda_function_name" {
    description = "The lambda function name"
    type = string
}

variable "project_tags" {
  description = "A map of tags for my project"
  type        = map(string)
}
variable "dynamodb_table_arn" {
    description = "The DynamoDB table arn"
    type = string
}

variable "dynamodb_name" {
    description = "The Dynamo DB table name"
    type = string
} 