resource "aws_lambda_function" "lambda" {
  filename         = "/tmp/${var.name}.zip"
  function_name    = var.name
  role             = aws_iam_role.iam_role.arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout          = var.timeout

  vpc_config {
    security_group_ids = var.vpc_security_group_ids
    subnet_ids         = var.vpc_subnet_ids
  }

  environment {
    variables = var.environment_variables
  }
}

# CloudWatch
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 30
}
