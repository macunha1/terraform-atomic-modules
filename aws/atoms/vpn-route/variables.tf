variable "vpn_ec2_instance_name" {
  description = "EC2 instance running the VPN to route requests"
  type        = string
}

variable "vpn_subnet_route_cidr" {
  description = "Subnet range (CIDR) to configure the routing"
  type        = string
}
