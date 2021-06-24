variable "name" {
  description = "Name of secret to store"
  type        = string
}

variable "value" {
  description = "Secret value to store"
  default     = ""
  type        = string
}

variable "create_version" {
  description = "Whether or not to create the Secrets Manager version"
  type        = bool
  default     = true
}

variable "description" {
  type    = string
  default = "Terraform-Managed secret"
}

variable "tags" {
  description = "User-Defined tags"
  type        = map(string)
  default     = {}
}
