data "aws_vpc" "current" {
  tags = {
    Name = "${var.env}-${var.project_name}-vpc"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.current.id}"

  tags = {
    Name = "${var.env}-${var.project_name}-private-*-subnet"
  }
}
