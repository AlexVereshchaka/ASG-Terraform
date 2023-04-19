/* Здесь мы создали два аларма метрики CloudWatch. 
Один для случая, когда загрузка процессора на сервере превышает 80%,
и второй для случая, когда загрузка процессора на сервере падает ниже 50%.
Оба аларма вызывают Lambda функцию var.lambda_function_arn, 
которая будет перенаправлять трафик на другой сервер, если это необходимо. */
terraform {
  backend "s3" {
  bucket         = "asg-backend-194"
    key            = "modules/cloud-watch/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
  required_version = ">= 1.0.2"
}

resource "aws_cloudwatch_metric_alarm" "cpu_usage_high" {
  alarm_name          = var.alarm_name_high
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = var.metric_name
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = "Average"
  threshold           = var.threshold
  alarm_description   = "This metric monitors EC2 instance CPU utilization"
  alarm_actions       = [var.alarm_actions]
  dimensions = {
    InstanceId = var.aws_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_usage_low" {
  alarm_name          = "CPU usage too low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = var.metric_name
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = "Average"
  threshold           = var.threshold
  alarm_description   = "This metric monitors EC2 instance CPU utilization"
  alarm_actions       = [var.alarm_actions]
  dimensions = {
    InstanceId = "${var.aws_instance_id}"
  }
}
