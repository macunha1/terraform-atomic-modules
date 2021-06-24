variable "cidr_block" {
  description = "Default private CIDR block for the Virtual Private Cloud (VPC)"
  type        = string
}

variable "create_nat_gateway" {
  description = "Whether or not to create the NAT Gateway for the private subnets"
  type        = bool
  default     = true
}

variable "environment" {
  description = "The environment it will serve (prod, staging, etc)"
  type        = string
}

variable "region" {
  description = "GCP compute region to create the VPC"
  type        = string
}

variable "project_name" {
  description = "Which project should host this VPC?"
  type        = string
}

variable "routing_mode" {
  description = "The network-wide GCP routing mode to use"
  type        = string
  default     = "GLOBAL"
}

variable "subnet" {
  description = "Map containing the number of subnets: private and public"

  type = object({
    private = number
    public  = number
  })

  default = {
    private = 2
    public  = 2
  }
}

variable "subnet_cidr_bits" {
  description = "Number of bits to increment using the cidrsubnet method"
  type        = number
  default     = 8
}
