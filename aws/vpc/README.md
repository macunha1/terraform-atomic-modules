## AWS Virtual Private Cloud module

### Introduction

It will create the necessary resources to setup a AWS VPC following [Amazon's paper on VPC Design](https://aws.amazon.com/answers/networking/aws-single-vpc-design/)

This module will create:
 - A Virtual private cloud (network);
 - Some subnets (public and private) inside it based on parameters;
 - An internet gateway to allow communication with the internet;
 - An NAT gateway to allow private instances to access the internet;
 - A default security group which allows internal traffic between instances in the same VPC.

### Usage example

 ```hcl
 module "aws_production_vpc" {
  source       = "git@github.com:macunha1/terraform-modules.git//aws/vpc"
  project_name = "example"
  region       = "us-east-1"
  env          = "production"
  cidr_block   = "172.20.0.0/16"
  subnet       = {
    private    = 3
    public     = 2
  }
}
```
