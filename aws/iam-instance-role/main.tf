resource "aws_iam_role" "default" {
  name = "${var.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "default" {
  name = "${var.role_name}"
  role = "${aws_iam_role.default.name}"
}

resource "aws_iam_role_policy" "default" {
  name   = "${var.role_name}-policy"
  role   = "${aws_iam_role.default.id}"
  policy = "${var.role_policy_json}"
}
