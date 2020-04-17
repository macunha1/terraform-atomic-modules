variable "dns_zone_name" {
  description = "The name to create a DNS Zone in Route 53"
  type        = string
}

variable "comment" {
  description = "The optional commentary to describe this Zone"
  type        = string
  default     = ""
}

