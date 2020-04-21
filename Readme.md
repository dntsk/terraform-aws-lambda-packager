# AWS Lambda packager Terraform module

Terraform module which creates and deploy AWS Lambda with required python modules.

## Usage

```hcl
module "example" {
  source = "dntsk/lambda-packager"

  source_dir = "lambdas/example"
  filename   = "example.py"
  handler    = "example.lambda_handler"

  name = "example"

  environment_variables = {
    VAR   = "example_variable"
  }
}
```
