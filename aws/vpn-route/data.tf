data "aws_instance" "vpn_instance" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpn_name}"]
  }
}

data "aws_subnet" "current" {
  id = "${data.aws_instance.vpn_instance.subnet_id}"
}

data "aws_route_tables" "from_vpc" {
  vpc_id = "${data.aws_subnet.current.vpc_id}"
}
