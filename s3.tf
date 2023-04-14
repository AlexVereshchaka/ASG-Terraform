locals {
  function_name = "my_lambda_function"
}

# Создаём S3 бакет для хранения zip-архива
resource "aws_s3_bucket" "lambda_bucket" {
  bucket_prefix = "my-lambda-bucket"
}

# Архивируем файл lambda_function.py в zip-архив
data "archive_file" "lambda_archive" {
  type = "zip"

  source_file      = "lambda.py"
  output_file_path = "./lambda_function.zip"
}

# Загружаем zip-архив в S3 бакет
resource "aws_s3_bucket_object" "lambda_object" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_function.zip"

  source = data.archive_file.lambda_archive.output_path
}

