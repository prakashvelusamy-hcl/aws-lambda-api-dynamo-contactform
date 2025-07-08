resource "aws_sns_topic_policy" "allow_lambda_publish" {
  arn    = aws_sns_topic.contact_form_notifications.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Principal: "*",
        Action: "SNS:Publish",
        Resource: aws_sns_topic.contact_form_notifications.arn,
        Condition: {
          ArnLike: {
            "aws:SourceArn": var.lambda_arn
          }
        }
      }
    ]
  })
}