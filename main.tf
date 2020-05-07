resource "null_resource" "tmp" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.tmp_dir}/${var.name}"
  }

  triggers = {
    the_trigger = timestamp()
  }
}

resource "null_resource" "copy" {
  provisioner "local-exec" {
    command = "cp -fr ${var.source_dir}/* ${var.tmp_dir}/${var.name}/"
  }

  depends_on = [null_resource.tmp]

  triggers = {
    the_trigger = timestamp()
  }
}

resource "null_resource" "pip" {
  provisioner "local-exec" {
    command = "pip3 install -r ${var.source_dir}/requirements.txt -t ${var.tmp_dir}/${var.name}"
  }

  depends_on = [null_resource.copy]

  triggers = {
    the_trigger = timestamp()
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${var.tmp_dir}/${var.name}"
  output_path = "/tmp/${var.name}.zip"

  depends_on = [null_resource.pip]
}

resource "aws_lambda_function" "lambda" {
  filename         = "/tmp/${var.name}.zip"
  function_name    = var.name
  role             = aws_iam_role.iam_role_policy.arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  vpc_config {
    security_group_ids = var.vpc_security_group_ids
    subnet_ids = var.vpc_subnet_ids
  }

  environment {
    variables = var.environment_variables
  }
}

resource "aws_iam_role" "iam_role_policy" {
  name = var.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
  role       = aws_iam_role.iam_role_policy.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# CloudWatch
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 30
}
