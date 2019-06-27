resource "random_id" "password" {
  byte_length = 8
}

locals {
  name = "${var.env}-${var.project_name}-${var.instance_of}"
}

resource "aws_db_subnet_group" "default" {
  count = "${var.use_multi_az
    && length(data.aws_subnet_ids.private.ids) > 1 ? 1 : 0}"

  name       = "${local.name}-subnets"
  subnet_ids = ["${data.aws_subnet_ids.private.ids}"]

  tags = {
    Name = "${local.name}-subnets"
  }
}

resource "aws_db_instance" "default" {
  depends_on = ["aws_db_subnet_group.default"]

  allocated_storage = "${var.storage_size}"
  storage_type      = "gp2"

  # Doesn't work
  # db_subnet_group_name = "${var.use_multi_az ? resource.aws_db_subnet_group.default.id : ""}"
  db_subnet_group_name = "${var.use_multi_az ? "${local.name}-subnets" : ""}"

  name           = "${replace("${local.name}", "/[^a-z0-9]/", "")}"
  engine         = "${var.db_engine}"
  instance_class = "${var.db_instance_type}"
  username       = "${var.db_username}"
  password       = "${random_id.password.b64}"
  multi_az       = "${var.use_multi_az}"
  identifier     = "${local.name}"

  tags = {
    Name = "${local.name}"
  }
}
