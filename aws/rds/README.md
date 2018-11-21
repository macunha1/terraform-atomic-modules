## AWS RDS module

### Introduction

This module will create:
 - A database subnet group for the database;
 - A RDS database;

### Usage example

 ```hcl
module "aws_production_unknownapp_rds" {
  source           = "git@github.com:macunha1/terraform-modules.git//aws/rds"
  env              = "${module.aws_production_vpc.environment}"
  project_name     = "${module.aws_production_vpc.project_name}"
  db_instance_type = "db.t2.micro"
  instance_of      = "unknown_application"
  use_multi_az     = true
  db_engine        = "postgresql"
  storage_size     = 64
}
 ```
