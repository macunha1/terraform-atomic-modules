## AWS Route 53 DNS Zone

### Introduction

Create a simple DNS zone using Route 53

### Usage example

 ```hcl
 module "aws_production_kubernetes_dns" {
  source        = "git@github.com:macunha1/terraform-modules.git//aws/route53-zone"
  dns_zone_name = "some.example.com"
  comment       = "Some DNS zone for example"
}
```
