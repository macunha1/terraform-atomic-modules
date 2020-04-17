data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "default" {
  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_instance_profile" "default" {
  name = var.role_name
  role = aws_iam_role.default.name
}

resource "aws_iam_role_policy" "default" {
  name   = "${var.role_name}-policy"
  role   = aws_iam_role.default.id
  policy = var.role_policy_json
}

