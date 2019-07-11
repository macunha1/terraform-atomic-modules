## GCP Virtual Machine (Cloud Compute instance) module

### Introduction

This module will create:
 - An GCP Cloud Compute (VM) instance containing one root disk, being it private or public;
 - An GCP Static IP or not, based on the parameters;
 - An aditional GCP Cloud Compute disk (for data, apart from the root) for each instance or not, based on the parameters;
 - Attach each Cloud compute disk at the respective instance.

### Usage example

 ```hcl
module "gcp_production_unknown_cluster" {
  source              = "git@github.com:macunha1/terraform-modules.git//aws/vm"
  project_name        = "${module.gcp_production_vpc.project_name}"
  subnetworks         = "${module.gcp_production_vpc.private_subnets}"
  instance_type       = "n1-standard-2"
  instance_name       = "unknown-cluster"
  instance_count      = 3
  instance_image      = "${var.default_images["debian"]}"
  
  static_public_ip    = false
  create_data_volumes = true
  data_volume_size    = 50
  data_volume_type    = "pd-standard" # or "pd-ssd", you choose it

  env = "${module.gcp_production_vpc.environment}"
}
```
