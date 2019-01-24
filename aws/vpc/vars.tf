variable "cidr_block" {
  description = "Default private CIDR block for the Virtual Private Cloud (VPC)"
  type        = "string"
}

variable "create_nat_gateway" {
  description = "Whether or not to create the NAT Gateway for the private subnets"
  default     = true
}

variable "env" {
  # Useful for cases where you need to isolate access to resources
  # so, you could securely run applications without interaction
  # from undesirable places
  description = "The environment it will serve (prod, staging, etc)"

  type = "string"
}

variable "region" {
  description = "AWS Region to create this Virtual Private Cloud"
  type        = "string"
}

variable "project_name" {
  description = "The project name that this VPC will serve"
  type        = "string"
}

variable "subnet" {
  description = "The map containing the number of subnets: private and public"
  type        = "map"

  default = {
    private = 2
    public  = 2
  }
}
