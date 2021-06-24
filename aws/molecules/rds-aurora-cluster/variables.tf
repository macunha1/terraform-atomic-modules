variable "instance_name" {
  description = "What is the name to give for the database instance?"
  type        = string
}

variable "family" {
  description = "The DB cluster parameter group family name for AWS Aurora"
  type        = string
  default     = "aurora-postgresql10"
}

variable "engine" {
  description = "The AWS Aurora Database Cluster Engine to use"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_mode" {
  description = "The AWS Aurora Database Cluster Engine mode to use (e.g. serverless)"
  type        = string
  default     = "serverless"
}

variable "engine_version" {
  description = "The AWS Aurora Database Cluster Engine version to use"
  type        = string
  default     = "10.7"
}

variable "database_secret_name" {
  description = "The Database secret name stored in the AWS Secrets Manager"
  type        = string
  default     = "aurora-serverless-secrets"
}

variable "create_database_secret" {
  description = <<EOF
Whether or not to create the AWS Secrets Manager Secret containing the database
password. Note that var.create_random_database_password depends on this one to
store the generated password.

If set to false, the module will try to read an existing secret using the
var.database_secret_name value.
EOF

  type    = bool
  default = true
}

variable "create_random_database_password" {
  description = "Whether or not to generate a password for the database secret"
  type        = bool
  default     = true
}

variable "random_database_password_length" {
  description = "Length (i.e. size in characters) of the generated password"
  type        = number
  default     = 24
}

variable "subnets" {
  description = "List of subnets to include database as availability zones"
  type        = list(string)
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = number
  default     = 7
}

variable "vpc_id" {
  description = "The VPC ID where the subnets are located"
  type        = string
}

variable "instance_type" {
  description = "Database Instance type to use"
  type        = string
  default     = "db.r4.large"
}

variable "min_capacity" {
  description = "The minimum capacity for ACU (Aurora capacity units) to use for this cluster"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "The maximum capacity for ACU (Aurora capacity units) to use for this cluster"
  type        = number
  default     = 8
}

variable "tags" {
  description = "A map of tags to add for the resources"
  type        = map(string)
  default     = {}
}
