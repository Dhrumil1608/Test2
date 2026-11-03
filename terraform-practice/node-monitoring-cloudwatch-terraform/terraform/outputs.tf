output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.app.public_ip
}

output "app_url" {
  description = "Node.js application URL"
  value       = "http://${aws_instance.app.public_ip}:3000"
}

output "sns_topic_arn" {
  description = "SNS notification topic ARN"
  value       = aws_sns_topic.alarms.arn
}

output "dashboard_name" {
  description = "CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "app_log_group" {
  value = aws_cloudwatch_log_group.app.name
}

output "event_log_group" {
  value = aws_cloudwatch_log_group.alarm_events.name
}