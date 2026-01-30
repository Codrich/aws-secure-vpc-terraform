output "app_sg_id" { value = aws_security_group.app.id }
output "ec2_instance_profile_name" { value = aws_iam_instance_profile.ec2.name }
output "vpc_flowlog_role_arn" { value = aws_iam_role.flowlogs.arn }
output "alb_sg_id" { value = aws_security_group.alb.id }
