variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "node-monitoring"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "alarm_email" {
  description = "Email for SNS notifications"
  type        = string
}

variable "app_log_retention_days" {
  type    = number
  default = 14
}

variable "event_log_retention_days" {
  type    = number
  default = 30
}