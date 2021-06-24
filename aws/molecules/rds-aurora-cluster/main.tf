resource "aws_db_parameter_group" "default" {
  name        = "${var.instance_name}-parameter-group"
  family      = var.family
  description = "Default parameter group for the ${var.instance_name} Database"

  tags = var.tags
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "${var.instance_name}-cluster-parameter-group"
  family      = var.family
  description = "Default parameter group for the ${var.instance_name} Database Cluster"

  tags = var.tags
}

resource "random_password" "database" {
  count = var.create_random_database_password ? 1 : 0

  length = var.random_database_password_length

  special          = true
  override_special = "_%@"
}

module "aurora_database_password" {
  source = "../../atoms/secretsmanager-secret/"

  name        = var.database_secret_name
  description = "AWS RDS cluster ${var.instance_name} default (root) password"

  # NOTE: An empty value forces the module to read from the existing secret
  # based on var.database_secret_name
  value = try(random_password.database[0].result, "")

  create_secret = var.create_database_secret

  tags = var.tags
}

module "aws_rds_cluster_aurora" {
  source         = "git::https://github.com/terraform-aws-modules/terraform-aws-rds-aurora.git?ref=v2.29.0"
  name           = var.instance_name
  engine         = var.engine
  engine_mode    = var.engine_mode
  engine_version = var.engine_version

  replica_scale_enabled = false
  replica_count         = 0
  backtrack_window      = 10 # ignored in serverless

  subnets             = var.subnets
  vpc_id              = var.vpc_id
  monitoring_interval = 60
  instance_type       = var.instance_type

  apply_immediately     = true
  skip_final_snapshot   = true
  storage_encrypted     = true
  copy_tags_to_snapshot = true

  preferred_backup_window      = "02:50-03:20"
  preferred_maintenance_window = "sun:01:48-sun:02:18"

  backup_retention_period = var.backup_retention_period
  database_secret_name    = var.database_secret_name

  db_parameter_group_name         = aws_db_parameter_group.default.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.id

  scaling_configuration = {
    auto_pause               = true
    max_capacity             = var.max_capacity
    min_capacity             = var.min_capacity
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}
