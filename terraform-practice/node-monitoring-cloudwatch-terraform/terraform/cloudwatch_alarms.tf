resource "aws_cloudwatch_metric_alarm" "app_errors" {
  alarm_name        = "${var.project_name}-errors-greater-than-3"
  alarm_description = "More than 3 application errors in 5 minutes"

  namespace   = "Application/NodeApp"
  metric_name = "ErrorCount"

  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  datapoints_to_alarm = 1

  threshold           = 3
  comparison_operator = "GreaterThanThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]

  ok_actions = [
    aws_sns_topic.alarms.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name        = "${var.project_name}-cpu-greater-than-70"
  alarm_description = "EC2 CPU utilization greater than 70 percent"

  namespace = "AWS/EC2"

  metric_name = "CPUUtilization"

  dimensions = {
    InstanceId = aws_instance.app.id
  }

  statistic           = "Average"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1

  threshold           = 70
  comparison_operator = "GreaterThanThreshold"

  treat_missing_data = "missing"

  alarm_actions = [
    aws_sns_topic.alarms.arn
  ]

  ok_actions = [
    aws_sns_topic.alarms.arn
  ]
}