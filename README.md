[![Logo](https://dntsk.dev/assets/logo_transparent_crop_360.png)](https://dntsk.dev)

[![Maintained](https://img.shields.io/badge/maintained%20by-dntsk.dev-blue.svg)](https://dntsk.dev/) [![Terraform version](https://img.shields.io/badge/terraform-~>%20v0.12.24-33cc33.svg)](https://github.com/hashicorp/terraform/releases) [![GitHub tag](https://img.shields.io/github/tag/dntsk/terraform-aws-lambda-packager.svg)](https://github.com/dntsk/terraform-aws-lambda-packager/tags/) [![MIT license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT) 

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