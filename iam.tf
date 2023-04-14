#Создание IAM Role для Lambda Function
resource "aws_iam_role" "lambda" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.lambda.name
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name = "cloudwatch-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
        Action = [
            "cloudwatch:GetMetricData",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:ListMetrics"
        ]
        Effect = "Allow"
        Resource = "*"
        }]
  })
}
resource "aws_iam_policy" "nlb_policy" {
  name = "nlb-policy"
  policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
    Action = [
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DeregisterTargets"
]
    Effect = "Allow"
    Resource = aws_lb.nlb.arn
    }
  ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
  role = aws_iam_role.lambda.name
}

resource "aws_iam_role_policy_attachment" "nlb_policy_attachment" {
  policy_arn = aws_iam_policy.nlb_policy.arn
  role = aws_iam_role.lambda.name
}

resource "aws_cloudwatch_metric_alarm" "alarm_to_lambda" {
  alarm_name = "my-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "80"
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions = [
    aws_lambda_permission.permission.arn,
    aws_lambda_function.redirect_traffic.arn
  ]
}

resource "aws_lambda_permission" "permission" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.redirect_traffic.arn
  principal = "events.amazonaws"
}

# Предоставляем права доступа на S3 бакет для выполнения функции Lambda
resource "aws_lambda_permission" "allow_s3_access" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda_function.arn

  principal  = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.lambda_bucket.arn
}

