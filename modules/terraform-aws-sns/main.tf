resource "aws_sns_topic" "contact_form_notifications" {
  name = "contact-form-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.contact_form_notifications.arn
  protocol  = "email"
  endpoint  = "prakash.velusamy@hcltech.com"
}



