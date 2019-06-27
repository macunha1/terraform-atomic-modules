resource "aws_vpc" "default" {
  cidr_block = "${var.cidr_block}"

  enable_dns_support   = true
  enable_dns_hostnames = true

  lifecycle {
    create_before_destroy = false
  }

  tags = {
    Name = "${var.env}-${var.project_name}-vpc"
  }
}

resource "aws_subnet" "private" {
  count  = "${var.subnet["private"]}"
  vpc_id = "${aws_vpc.default.id}"

  availability_zone = "${element(
    data.aws_availability_zones.available.names,
    (count.index % length(data.aws_availability_zones.available.names)))}"

  cidr_block = "${cidrsubnet(aws_vpc.default.cidr_block,
                             var.subnet_cidr_bits,
                             count.index)}"

  tags = {
    Name = "${format("%v-%v-private-%02d-subnet",
                     var.env,
                     var.project_name,
                     count.index+1)}"
  }
}

resource "aws_subnet" "public" {
  count      = "${var.subnet["public"]}"
  depends_on = ["aws_internet_gateway.default"]
  vpc_id     = "${aws_vpc.default.id}"

  availability_zone = "${element(
    data.aws_availability_zones.available.names,
    count.index % length(data.aws_availability_zones.available.names))}"

  cidr_block = "${cidrsubnet(aws_vpc.default.cidr_block,
                             var.subnet_cidr_bits,
                             count.index + 127)}"

  map_public_ip_on_launch = true

  tags = {
    Name = "${format("%v-%v-public-%02d-subnet",
                     var.env,
                     var.project_name,
                     count.index+1)}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id     = "${aws_vpc.default.id}"
  depends_on = ["aws_vpc.default"]

  tags = {
    Name = "${format("%v-%v-igw", var.env, var.project_name)}"
  }
}

resource "aws_eip" "nat_gateway" {
  count      = "${var.create_nat_gateway ? 1 : 0}"
  vpc        = true
  depends_on = ["aws_internet_gateway.default"]
}

resource "aws_nat_gateway" "default" {
  count         = "${var.create_nat_gateway ? 1 : 0}"
  allocation_id = "${aws_eip.nat_gateway.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"
  depends_on    = ["aws_internet_gateway.default", "aws_subnet.public"]

  tags = {
    Name = "${format("%v-%v-nat-gw-%02d", var.env, var.project_name, 1)}"
  }
}

resource "aws_security_group" "allow_all_internal" {
  name        = "allow_all_internal"
  description = "Allow all internal traffic and all out"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
