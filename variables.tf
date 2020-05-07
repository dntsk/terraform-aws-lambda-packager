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
  type = list(string)
  description = "List of subnets ids for VPC"
  default = []
}

variable "vpc_security_group_ids" {
  type = list(string)
  description = "List of security groups ids for VPC"
  default = []
}

data "aws_region" "current" {}
