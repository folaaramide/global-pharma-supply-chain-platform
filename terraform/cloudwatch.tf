resource "aws_sns_topic" "alerts" {

  name = "pharma-alerts"

}

resource "aws_sns_topic_subscription" "email" {

  topic_arn = aws_sns_topic.alerts.arn

  protocol = "email"

  endpoint = "afolabiaramide@outlook.com"

}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {

  alarm_name = "high-cpu"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 120

  statistic = "Average"

  threshold = 70

  alarm_description = "CPU usage too high"

  dimensions = {

    InstanceId = aws_instance.app.id

  }

  alarm_actions = [

    aws_sns_topic.alerts.arn

  ]

}