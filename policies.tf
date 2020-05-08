resource "aws_iam_policy" "policy" {
  name   = "lambda_${var.name}_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role" "iam_role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.iam_role_policy.json
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.policy.arn
}
