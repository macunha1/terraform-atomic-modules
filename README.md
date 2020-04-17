# Terraform Modules

HCL templates to manage resources using [Terraform](https://www.terraform.io/)

## Requirements

Install Terraform and configure it following [instructions on its site](https://www.terraform.io/docs/configuration/index.html)

Then set your cloud provider necessary credentials, create backend state, and let's get work done!

## Available modules

Inside each module directory you should find their README and usage examples.

The available modules are:

### AWS

```
aws
├── aurora
├── iam-instance-role
├── rds
├── route53-zone
├── s3-bucket
├── vm
├── vpc
├── vpn-gateway
└── vpn-route
```

### GCP

```
gcp
├── sql
├── vm
└── vpc
```

## Contributing

If you find any bug or issue, let me know, and I'll work to solve it ASAP.

Suggestions (or Pull Requests) are welcome!
