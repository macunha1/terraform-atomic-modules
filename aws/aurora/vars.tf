variable "env" {
  description = "The environment (production, staging, etc) that this cluster will serve"
  type        = "string"
}

variable "project_name" {
  description = "The project name that this cluster will serve"
  type        = "string"
}

variable "target_subnet_ids" {
  description = "Target subnet ids to create a subnet group for this cluster"
  default     = "private"
}

variable "db_engine" {
  description = "The database engine to run inside Aurora (mysql, postgresql)"
  type        = "string"
  default     = "postgresql"
}

variable "db_name" {
  description = "Default database name"
  type        = "string"
  default     = "default"
}

variable "db_instance_type" {
  description = "Default database instance type"
  type        = "string"
  default     = "db.t2.micro"
}

variable "db_username" {
  description = "Database default username (for the root user)"
  type        = "string"
  default     = "root"
}

variable "number_of_nodes" {
  description = "Number of instances to create inside this cluster"
  default     = 3
}

variable "enable_public_access" {
  description = "Whether or not to enable this cluster to be publicly accessible"
  default     = false
}
