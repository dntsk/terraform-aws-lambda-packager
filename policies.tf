resource "aws_iam_policy" "policy" {
  count  = var.custom_iam_role ? 0 : 1
  name   = "lambda_${var.name}_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role" "iam_role" {
  count              = var.custom_iam_role ? 0 : 1
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.iam_role_policy.json
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
  count      = var.custom_iam_role ? 0 : 1
  role       = join("", aws_iam_role.iam_role.*.name)
  policy_arn = join("", aws_iam_policy.policy.*.arn)
}
