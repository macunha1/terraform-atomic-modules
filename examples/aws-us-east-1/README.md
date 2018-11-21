# AWS usage examples
HCL templates to create resources using these Terraform modules

## Requirements

1. Configure your AWS CLI (since Terraform uses AWS API, it's pretty much the same)
    1.1. Set your AWS configurations with `aws configure` or set environment variables following this [guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).
    It's recommended to use a AWS profile inside your configuration.
2. Create a backend for states in S3 with
    ```bash
    aws s3 --region us-east-1 s3://some-state-bucket
    ```
3. Let's get work done!

## Usage

To execute it, you just need to run:
```shell
terraform init -var-file=/path/to/terraform-modules/default.tfvars .
```
