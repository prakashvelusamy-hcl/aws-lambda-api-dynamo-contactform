output "lambda_integration_uri_arn" {
value = aws_lambda_function.lambda.invoke_arn
}
output "lambda_arn" {
    value = aws_lambda_function.lambda.arn
}