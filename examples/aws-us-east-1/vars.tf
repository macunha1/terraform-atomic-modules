variable "default_amis" {
  description = "AMI map that facilitates to store it and change versions"
  type        = "map"
}

variable "role_policy_json" {
  description = "Just declared to read the JSON with file() instead of typing"
  type        = "string"
}
