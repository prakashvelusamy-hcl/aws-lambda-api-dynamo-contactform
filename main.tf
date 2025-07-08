module "lambda" {
  source = "./modules/terraform-aws-lambda"
  api_gateway_arn = module.api_gateway.api_gateway_arn
  aws_lambda_function_name = var.aws_lambda_function_name
  project_tags = var.project_tags
  dynamodb_table_arn = module.dynamo_db_table.dynamodb_table_arn
}

module "api_gateway" {
  source = "./modules/terraform-aws-apigateway"
  lambda_integration_uri_arn = module.lambda.lambda_integration_uri_arn
  aws_region = var.aws_region
  route_key= var.route_key
  project_tags = var.project_tags
}

module "dynamo_db_table" {
    source = "./modules/terraform-aws-dynamodb"
    dynamodb_name = var.dynamodb_name
    dynamodb_billing_mode = var.dynamodb_billing_mode
    project_tags = var.project_tags
}
