resource "aws_route53_zone" "main" {
  name    = "${var.dns_zone_name}"
  comment = "${var.comment}"
}
