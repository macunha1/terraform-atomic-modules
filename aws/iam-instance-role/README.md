## AWS IAM Instance Role module

### Introduction

This module will create an instance based role for EC2 and allow this instance to assume role in STS

### Usage example

```hcl
data "aws_iam_policy_document" "unknown_application_policies" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
      "s3:ListBucketVersions"
    ]
    effect = "Allow" # it's the default/implicit value
    resources = [
      "arn:aws:s3:::some-bucket-name"
      # Preferably: "arn:aws:s3:::${var.s3_bucket_name}"
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::some-bucket-name/*"
      # Preferably: "arn:aws:s3:::${var.s3_bucket_name}/*"
    ]
  }
}

module "aws_production_unknown_application_role" {
 source           = "git@github.com:macunha1/terraform-modules.git//aws/iam-instance-role"
 role_name        = "unknown_application_instance"
 role_policy_json = data.aws_iam_policy_document.example.json
}
```
