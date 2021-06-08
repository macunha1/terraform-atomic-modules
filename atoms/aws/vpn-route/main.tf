resource "aws_route" "default" {
  for_each = toset(data.aws_route_tables.from_vpc.ids)

  route_table_id         = data.aws_route_tables.from_vpc.ids[each.value]
  destination_cidr_block = var.vpn_subnet_route_cidr
  instance_id            = data.aws_instance.vpn.id
}

