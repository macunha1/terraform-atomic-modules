## GCP Virtual Private Cloud module

### Introduction

This module will create:
 - A Virtual private cloud (network);
 - Some subnets (public and private) inside it based on parameters;

### Usage example

 ```hcl
module "aws_production_gcp" {
  source       = "git@github.com:macunha1/terraform-modules.git//aws/gcp"
  project_name = "example"
  region       = "us-central1"
  env          = "production"
  cidr_block   = "172.20.0.0/16"
  subnet       = {
    private    = 3
    public     = 2
  }
}
```
