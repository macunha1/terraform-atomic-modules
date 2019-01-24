resource "aws_eip" "default" {
  vpc              = true
  public_ipv4_pool = "amazon"
}

resource "aws_vpn_gateway" "main" {
  vpc_id = "${data.aws_vpc.current.id}"

  tags = "${merge(map("Name", format("%v-%v-vpn-gw", var.env, var.vpn_gateway_name),
                      "environment", var.env),
          var.custom_tags)}"
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 6500
  ip_address = "${aws_eip.default.public_ip}"
  type       = "ipsec.1"

  tags = "${merge(map("Name", format("%v-%v-cgw", var.env, var.vpn_gateway_name),
                      "environment", var.env),
          var.custom_tags)}"
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.main.id}"
  customer_gateway_id = "${aws_customer_gateway.main.id}"
  type                = "ipsec.1"
  static_routes_only  = "${!var.use_bgp}"
}
