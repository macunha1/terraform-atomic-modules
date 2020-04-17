resource "aws_route" "to_vpn" {
  count                  = length(data.aws_route_tables.from_vpc.ids)
  route_table_id         = data.aws_route_tables.from_vpc.ids[count.index]
  destination_cidr_block = var.vpn_subnet_range
  instance_id            = data.aws_instance.vpn_instance.id
}

