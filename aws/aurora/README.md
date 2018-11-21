## AWS Aurora module

### Introduction

This module will create:
 - A database subnet group for the cluster;
 - An Aurora database cluster;
 - Some instances inside the Aurora database cluster (based on parameters);

### Usage example

 ```hcl
module "aws_production_unknownapp_aurora" {
  source               = "git@github.com:macunha1/terraform-modules.git//aws/aurora"
  env                  = "${module.aws_production_vpc.environment}"
  project_name         = "${module.aws_production_vpc.project_name}"
  taget_subnet_ids     = "${module.aws_production_vpc.private_subnets}"
  db_engine            = "mysql"
  db_instance_type     = "db.t2.micro"
  number_of_nodes      = 3
  enable_public_access = false
}
 ```
