output "id" {
  value = "${aws_vpc.default.id}"
}

output "private_subnets" {
  value = "${aws_subnet.private.*.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "environment" {
  value = "${var.env}"
}

output "project_name" {
  value = "${var.project_name}"
}
