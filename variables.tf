data "aws_region" "current" {}

variable "source_dir" {
  description = "Lambda source directory"
  type        = string
}

variable "filename" {
  description = "Lambda's file name"
  type        = string
}

variable "runtime" {
  description = "Runtime for Lambda function"
  type        = string
  default     = "python3.7"
}

variable "custom_iam_role" {
  description = "Provide true if you want to have your own IAM role in Lambda function"
  default     = false
  type        = bool
}

variable "iam_role_arn" {
  description = "IAM role ARN. Available if custom_iam_role set to true"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Lambda handler"
  type        = string
  default     = "labmda_handler"
}

variable "name" {
  description = "Lambda name"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables"
  type        = map(string)
  default     = {}
}

variable "tmp_dir" {
  description = "Temp directory to collect package"
  type        = string
  default     = "/tmp/lambda_pack"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "List of subnets ids for VPC"
  default     = []
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security groups ids for VPC"
  default     = []
}

variable "timeout" {
  type        = string
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = 300
}

locals {
  partition_map = map(
    "cn-north-1", "aws-cn",
    "cn-northwest-1", "aws-cn"
  )
  iam_map = map(
    "cn-north-1", "amazonaws.com.cn",
    "cn-northwest-1", "amazonaws.com.cn"
  )
}

locals {
  aws_partition           = lookup(local.partition_map, data.aws_region.current.name, "aws")
  aws_iam_pricipal_suffix = lookup(local.iam_map, data.aws_region.current.name, "amazonaws.com")
}
