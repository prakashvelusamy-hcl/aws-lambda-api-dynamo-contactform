variable "dynamodb_name" {
    description = "The Dynamo DB table name"
    type = string
} 
variable "dynamodb_billing_mode" {
    description = "The Dynamo DB billing mode"
    type = string
}
variable "project_tags" {
  description = "A map of tags to assign to the Lambda function."
  type        = map(string)
}