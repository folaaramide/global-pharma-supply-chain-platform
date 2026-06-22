resource "aws_cloudwatch_metric_alarm" "high_cpu" {

  alarm_name = "pharma-high-cpu"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 300

  statistic = "Average"

  threshold = 70

  alarm_description = "CPU usage above 70%"

  dimensions = {

    InstanceId = aws_instance.app.id

  }

  alarm_actions = [

    aws_sns_topic.alerts.arn

  ]

}