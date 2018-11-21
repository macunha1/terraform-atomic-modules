variable "env" {
  description = "The environment (production, staging, etc) that this database will serve"
  type        = "string"
}

variable "project_name" {
  description = "The project name that this database will serve"
  type        = "string"
}

variable "target_subnet_ids" {
  description = "Target subnet ids to create a subnet group for this database"
  default     = "private"
}

variable "use_multi_az" {
  description = "Whether or not to create this database in a multi AZ approach"
  default     = false
}

variable "storage_size" {
  description = "Disk size in GB to create for this database"
  default     = 50
}

variable "instance_of" {
  description = "The name to give to this instance"
  type        = "string"
}

variable "db_engine" {
  description = "The database engine to run inside RDS (mysql, postgresql, etc)"
  type        = "string"
  default     = "postgresql"
}

variable "db_name" {
  description = "Default database name inside the database server"
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
