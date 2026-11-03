resource "aws_cloudwatch_log_group" "app" {
  name              = "/aws/ec2/${var.project_name}/app"
  retention_in_days = var.app_log_retention_days
}

resource "aws_cloudwatch_log_group" "alarm_events" {
  name              = "/aws/events/${var.project_name}-alarms"
  retention_in_days = var.event_log_retention_days
}

resource "aws_cloudwatch_log_metric_filter" "errors" {
  name           = "${var.project_name}-error-filter"
  log_group_name = aws_cloudwatch_log_group.app.name

  pattern = "{ $.level = \"ERROR\" }"

  metric_transformation {
    name          = "ErrorCount"
    namespace     = "Application/NodeApp"
    value         = "1"
    default_value = 0
  }
}