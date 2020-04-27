# AWS Lambda packager Terraform module

Terraform module which creates and deploy AWS Lambda with required python modules.

## Supported Terraform versions

* Terraform 0.12. Pin version to `~> v0.1`

## Usage

```hcl
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
```

## License

MIT Licensed. See LICENSE for full details.