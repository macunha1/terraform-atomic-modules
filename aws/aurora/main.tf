resource "random_id" "password" {
  byte_length = 8
}

locals {
  name = "${var.env}-${var.project_name}-aurora-${var.db_engine}"
}

resource "aws_db_subnet_group" "default" {
  name       = "${local.name}-subnets"
  subnet_ids = ["${var.target_subnet_ids}"]

  tags = {
    Name = "${local.name}-subnets"
  }
}

resource "aws_rds_cluster" "default" {
  depends_on = ["aws_db_subnet_group.default"]

  cluster_identifier      = "${local.name}-cluster"
  engine                  = "aurora-${var.db_engine}"
  db_subnet_group_name    = "${local.name}-subnets"
  database_name           = "${var.db_name}"
  master_username         = "${var.db_username}"
  master_password         = "${random_id.password.b64}"
  backup_retention_period = 5
  preferred_backup_window = "06:30-08:00"
}

resource "aws_rds_cluster_instance" "default" {
  depends_on = ["aws_rds_cluster.default"]
  count      = "${var.number_of_nodes}"

  identifier           = "${format("%v-%02d", local.name, count.index+1)}"
  cluster_identifier   = "${aws_rds_cluster.default.id}"
  instance_class       = "${var.db_instance_type}"
  db_subnet_group_name = "${local.name}-subnets"
  publicly_accessible  = "${var.enable_public_access}"

  engine = "aurora-${var.db_engine}"

  tags = {
    Name = "${local.name}"
  }
}
