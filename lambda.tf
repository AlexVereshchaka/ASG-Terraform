resource "aws_lambda_function" "redirect_traffic" {
  filename         = aws_s3_bucket_object.lambda_object.id
  function_name    = local.function_name
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.handler"
  runtime          = "python3.8"
  source_code_hash = data.archive_file.lambda_archive.output_base64sha256
}

resource "aws_lambda_function_environment" "my_lambda_function_env" {
  function_name = aws_lambda_function.my_lambda_function.id

  variables = {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    instance_id      = aws_instance.my_instance.id
  }
}