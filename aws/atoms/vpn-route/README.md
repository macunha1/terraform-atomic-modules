# AWS VPN Route module

## Introduction

Manages a VPN route on the routing table in order to configure site-to-site VPN
configuration. As of this writing, the module was implemented to support routing
through a IPsec VPN.

## Usage example

```hcl
module "aws_production_vpn_route" {
  source           = "git@github.com:macunha1/terraform-modules.git//atoms/aws/vpn_route?ref=a1b2c3d"
  vpn_name         = "awesome-strongswan"
  vpn_subnet_range = "${module.azure_production_vnet.virtual_network_cidr_block}"
}
```
