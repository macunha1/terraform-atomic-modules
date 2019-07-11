variable "env" {
  description = "The environment it will serve (prod, staging, etc)"
  type        = "string"
}

variable "project_name" {
  description = "GCP project name"
  type        = "string"
}

variable "region" {
  description = "GCP region"
  default     = "us-central1"
}

variable "instance_of" {
  description = "The name to give to this instance"
  type        = "string"
}

variable "database_instance_type" {
  description = "GCP Cloud SQL Instance type/tier"
  type        = "string"
  default     = "db-f1-micro"
}

variable "database_engine" {
  description = "GCP Compute image to boot the instance"
  type        = "string"
  default     = "MYSQL_5_7"
}

variable "use_multi_az" {
  description = "Whether or not to create this database in a multi AZ approach"
  default     = false
}

variable "vpc_network" {
  description = "GCP VPC network to connect this instance"
  type        = "string"
}

variable "database_storage_size" {
  description = "If creating an additional disk, specify the size for it"
  default     = 50
}
