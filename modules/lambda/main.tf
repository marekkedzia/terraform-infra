resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role_${var.name_suffix}"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda_policy_${var.name_suffix}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = "*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_attached_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/js/index.js"
  output_path = "${path.module}/index.zip"
}


resource "aws_lambda_function" "lambda_files" {
  filename         = data.archive_file.zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.zip.output_path)

  function_name = "lambda_files_${var.name_suffix}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = var.lambda_runtime

  environment {
    variables = {
      MONGO_URL             = var.mongo_url
      S3_BUCKET_NAME        = var.s3_bucket_name
      MONGO_DB_NAME         = var.db_name
      MONGO_COLLECTION_NAME = var.collection_name
    }
  }
}
