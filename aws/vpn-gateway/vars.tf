variable "env" {
  description = "The environment (production, staging, etc) for this VPN"
  type        = "string"
}

variable "vpc_id" {
  description = "The VPC Id to attach this VPN Gateway"
  type        = "string"
}

variable "vpn_gateway_name" {
  description = "The VPN Gateway name"
  type        = "string"
}

variable "custom_tags" {
  description = "Map of AWS tags to add for this VPN Gateway"
  type        = "map"
  default     = {}
}

variable "use_bgp" {
  description = "Whether or not to use BGP (dynamic routing) for this VPN Gateway"
  default     = false
}
