## AWS Aurora module

### Introduction

This module will create an instance based role for EC2 and allow this instance to assume role in STS

### Usage example

 ```hcl
module "aws_production_unknown_application_role" {
  source           = "git@github.com:macunha1/terraform-modules.git//aws/iam-instance-role"
  role_name        = "unknown_application_instance"
  role_policy_json = "${file("unknown_application_instance_role.json")}"
}
```
