## AWS Simple S3 bucket module

### Introduction

This module will create a Simple S3 bucket

### Usage example

```hcl
module "aws_unknown_s3_bucket" {
 source = "git@github.com:macunha1/terraform-modules.git//aws/s3-bucket"
 env    = "${module.aws_production_vpc.environment}"
 usage  = "unknown"
}
```
