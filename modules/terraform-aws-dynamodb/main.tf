resource "aws_dynamodb_table" "contact" {
  name           = var.dynamodb_name
  billing_mode   = var.dynamodb_billing_mode
  hash_key       = "id"
  range_key      = "timestamp"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N" 
  }

  tags = var.project_tags
}
