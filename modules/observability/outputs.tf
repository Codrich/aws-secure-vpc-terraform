output "alarm_topic_arn" {
  value = aws_sns_topic.alarms.arn
}

output "vpc_flowlog_log_group_name" {
  value = aws_cloudwatch_log_group.vpc_flowlogs.name
}

output "vpc_flowlog_log_group_arn" {
  value = aws_cloudwatch_log_group.vpc_flowlogs.arn
}

output "dashboard_name" {
  value = aws_cloudwatch_dashboard.ops.dashboard_name
}
