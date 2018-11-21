resource "random_shuffle" "default" {
  input        = ["${var.subnets}"]
  result_count = 1
  seed         = 3
}

data "aws_ami_ids" "default" {
  owners = ["${var.ami_info["owner"]}"]

  filter {
    name   = "name"
    values = ["${var.ami_info["name"]}"]
  }
}
