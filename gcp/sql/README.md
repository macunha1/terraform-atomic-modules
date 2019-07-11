## GCP Cloud SQL instance module

### Introduction

This module will create:
 - A single instance of Cloud SQL;

### Usage example

```hcl
module "gcp_production_unknownapp_sql" {
  source           = "git@github.com:macunha1/terraform-modules.git//gcp/sql"
  env              = "${module.gcp_production_vpc.environment}"
  project_name     = "${module.gcp_production_vpc.project_name}"
  instance_of      = "unknown_application"

  database_instance_type = "db-n1-standard-8"
  database_engine        = "MYSQL_5_6"
  database_storage_size  = 64
  use_multi_az           = true
  subnetworks            = "${module.gcp_production_vpc.private_subnets}"
}
 ```
