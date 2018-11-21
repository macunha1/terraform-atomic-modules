## AWS VPN Route module

### Introduction

It will create a simple VPN Route to be used for a site-to-site VPN configuration

### Usage example

 ```hcl
 module "aws_production_vpc" {
  source           = "git@github.com:macunha1/terraform-modules.git//aws/vpn-route"
  vpn_name         = "azure_brazil"
  vpn_subnet_range = "${module.azure_production_vnet.virtual_network_cidr_block}"
}
```
