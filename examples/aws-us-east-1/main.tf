module "aws_production_vpc" {
  source       = "git@github.com:macunha1/terraform-modules.git//aws/vpc"
  project_name = "example"
  region       = "us-east-1"
  env          = "production"
  cidr_block   = "172.20.0.0/16"

  subnet = {
    private = 3
    public  = 2
  }
}

module "aws_production_vpn_route" {
  source   = "git@github.com:macunha1/terraform-modules.git//aws/vpn-route"
  vpn_name = "unknown_datacenter_communication"

  # Usage example from another module:
  # vpn_subnet_range = "${module.azure_production_vnet.virtual_network_cidr_block}"
  vpn_subnet_range = "172.21.0.0/16"
}

module "aws_production_ssh_key_pair" {
  source    = "git::https://github.com/cloudposse/terraform-aws-key-pair.git?ref=0.2.5"
  namespace = "production"
  stage     = "example"
  name      = "unknown"
  # Make sure to ignore this path in .gitignore and to save the key in a safe place
  # For example, instead of storing a file, you can register it at Vault:
  # https://www.terraform.io/docs/providers/vault/r/generic_secret.html
  ssh_public_key_path   = "${path.module}/secrets"
  generate_ssh_key      = "true"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
  chmod_command         = "chmod 400 %v"
}

module "aws_production_unknown_cluster" {
  source              = "git@github.com:macunha1/terraform-modules.git//aws/vm"
  project_name        = "${module.aws_production_vpc.project_name}"
  subnets             = "${module.aws_production_vpc.private_subnets}"
  key_pair_name       = "${module.aws_production_ssh_key_pair.key_name}"
  instance_size       = "t3.medium"
  instance_of         = "unknown-cluster"
  instance_count      = 3
  use_public_subnet   = false
  create_data_volumes = true
  data_volume_size    = 50
  data_volume_type    = "gp2"
  ami_info            = "${var.default_amis["debian"]}"

  env = "${module.aws_production_vpc.environment}"
}

module "aws_unknown_s3_bucket" {
  source = "git@github.com:macunha1/terraform-modules.git//aws/s3-bucket"
  env    = "${module.aws_production_vpc.environment}"
  usage  = "unknown"
}

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

module "aws_production_unknown_application_role" {
  source    = "git@github.com:macunha1/terraform-modules.git//aws/iam-instance-role"
  role_name = "unknown_application_instance"

  # Example of a read-only policy for AWS IAM
  role_policy_json = "${file("unknown_application_instance_role.json")}"
}

module "aws_production_unknownapp_aurora" {
  source               = "git@github.com:macunha1/terraform-modules.git//aws/aurora"
  env                  = "${module.aws_production_vpc.environment}"
  project_name         = "${module.aws_production_vpc.project_name}"
  target_subnet_ids    = "${module.aws_production_vpc.private_subnets}"
  db_engine            = "mysql"
  db_instance_type     = "db.t2.micro"
  number_of_nodes      = 3
  enable_public_access = false
}
