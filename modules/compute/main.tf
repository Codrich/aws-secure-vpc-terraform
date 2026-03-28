############################################
# AMI (Amazon Linux 2023)
############################################
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

############################################
# LOCALS (User Data Script)
############################################
locals {
  user_data = <<-EOF
    #!/bin/bash
    set -e
    dnf update -y
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "OK: ${var.name_prefix}" > /usr/share/nginx/html/index.html
  EOF
}

############################################
# LAUNCH TEMPLATE
############################################
resource "aws_launch_template" "app" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = data.aws_ami.al2023.id

  # ✅ FORCE FREE TIER SAFE INSTANCE
  instance_type = "t3.micro"

  iam_instance_profile {
    name = var.ec2_instance_profile_name
  }

  vpc_security_group_ids = [var.app_sg_id]

  user_data = base64encode(local.user_data)

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # IMDSv2 enforced
    http_put_response_hop_limit = 2
  }

  # ✅ ENABLE MONITORING (GOOD PRACTICE)
  monitoring {
    enabled = true
  }
}

############################################
# AUTO SCALING GROUP
############################################
resource "aws_autoscaling_group" "app" {
  name                = "${var.name_prefix}-asg-app"
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1

  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arns

  # ✅ USE ALB HEALTH CHECK (IMPORTANT)
  health_check_type         = "ELB"
  health_check_grace_period = 120

  # ✅ PREVENT DESTROY BEFORE CREATE ISSUES
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-app"
    propagate_at_launch = true
  }
}

############################################
# CLOUDWATCH ALARM
############################################
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.name_prefix}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70

  alarm_actions = [var.alarm_topic_arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }
}
