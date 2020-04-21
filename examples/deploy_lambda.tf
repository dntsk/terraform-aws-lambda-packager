module "example" {
  source  = "dntsk/lambda-packager/aws"

  source_dir = "lambda"
  filename   = "example.py"
  handler    = "example.lambda_handler"

  name = "example"

  environment_variables = {
    VAR   = "example_variable"
  }
}
