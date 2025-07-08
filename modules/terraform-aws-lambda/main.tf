data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_app/contact.py"
  output_path = "${path.module}/lambda_app/contact.zip"
}
resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.aws_lambda_function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = "contact.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30
  memory_size      = 128
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

  environment {
    variables = {
      DYNAMODB_TABLE     = var.dynamodb_name
      SES_SENDER_EMAIL   = "prakashvelusamy1999@gmail.com" 
      SES_RECIPIENT_EMAIL = "prakashvelusamy1999@gmail.com"         
      AWS_REGION         = "ap-south-1"                      
    }
  }

  depends_on = [aws_iam_role.lambda_exec]
}



resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_arn}/*"
}