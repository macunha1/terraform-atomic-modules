resource "aws_instance" "default" {
  count         = "${var.instance_count}"
  ami           = "${element(data.aws_ami_ids.default.ids, 0)}"
  instance_type = "${var.instance_size}"
  key_name      = "${var.key_pair_name}"
  user_data     = "${var.instance_user_data}"

  subnet_id = "${element(random_shuffle.default.result, 0)}"

  iam_instance_profile = "${var.instance_profile}"

  tags = "${merge(map("Name", format("%v-%v-%02d", var.env, var.instance_of, count.index+1),
                      "environment", var.env),
            var.custom_tags)}"
}

resource "aws_eip" "default" {
  depends_on = ["aws_instance.default"]
  count      = "${var.static_public_ip ? var.instance_count : 0}"

  instance = "${element(aws_instance.default.*.id, count.index)}"
  vpc      = true

  tags = {
    Name        = "${var.env}-${var.instance_of}-eip"
  }
}

resource "aws_ebs_volume" "data_disks" {
  count             = "${var.create_data_volumes ? var.instance_count : 0}"
  size              = "${var.data_volume_size}"
  availability_zone = "${element(aws_instance.default.*.availability_zone,
                                 count.index)}"
  type              = "${var.data_volume_type}"

  tags = {
    Name = "${format("%v-%v-%02d-data", var.env, var.instance_of, count.index+1)}"
  }
}

resource "aws_volume_attachment" "attachment" {
  count       = "${var.create_data_volumes ? var.instance_count : 0}"
  device_name = "/dev/sdc"
  volume_id   = "${element(aws_ebs_volume.data_disks.*.id, count.index)}"
  instance_id = "${element(aws_instance.default.*.id, count.index)}"
}

/* TODO: Enable DNS management through Route53
resource "aws_route53_record" "public_fqdn" {
  count   = "${var.create_fqdn && var.use_public_subnet ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.default.zone_id}"
  name    = "${var.instance_of}.${data.aws_route53_zone.default.name}"
  type    = "A"
  ttl     = "${var.fqdn_ttl_in_dns}"

  records = ["${aws_eip.default.public_ip}"]
}

resource "aws_route53_record" "internal" {
  count   = "${var.create_fqdn && !var.use_public_subnet ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.internal.zone_id}"
  name    = "${var.instance_of}.${data.aws_route53_zone.internal.name}"
  type    = "A"
  ttl     = "${var.fqdn_ttl_in_dns}"

  records = ["${aws_instance.default.private_ip}"]
}
*/

