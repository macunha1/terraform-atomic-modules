data "aws_instance" "vpn" {
  filter {
    name   = "tag:Name"
    values = [var.vpn_name]
  }
}

data "aws_subnet" "default" {
  id = data.aws_instance.vpn_instance.subnet_id
}

data "aws_route_tables" "from_vpc" {
  vpc_id = data.aws_subnet.current.vpc_id
}
