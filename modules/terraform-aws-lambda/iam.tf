resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role_1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "LambdaDynamoDBAccessPolicy"
  description = "Allows Lambda to access DynamoDB table and SES"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "DynamoDBWriteAccess"
        Effect    = "Allow"
        Action    = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchGetItem"
        ]
        Resource  = var.dynamodb_table_arn
      },
      {
        Sid       = "CloudWatchLogging"
        Effect    = "Allow"
        Action    = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource  = "*"
      },
      {
        Sid       = "SESSendEmail"
        Effect    = "Allow"
        Action    = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource  = "*"
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}
