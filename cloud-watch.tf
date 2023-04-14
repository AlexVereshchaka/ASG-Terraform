resource "aws_cloudwatch_metric_alarm" "asg_alarm" {
  alarm_name = "my-asg-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 80

  alarm_description = "This metric monitors the CPU utilization of the Auto Scaling Group"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = [aws_autoscaling_policy.asg_policy.arn]

  tags = {
    Name = "my-asg-alarm"
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
  name = "my-asg-policy"
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 300
  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }
  target_value = 50.0
  }
  autoscaling_group_name= aws_autoscaling_group.asg.name
}


# Создание CloudWatch Alarm... Нужно заменить ресурс другим!!!!!! (Не поддерживается новыми версиями)
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "cpu-utilization-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Alarm when CPU utilization exceeds 80%"
  /* alarm_actions       = [aws_lambda_function.ar] */
}
