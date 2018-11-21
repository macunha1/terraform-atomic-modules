variable "role_name" {
  description = "Name to give to this AWS IAM Role"
  type        = "string"
}

variable "role_policy_json" {
  description = "Policy JSON for this AWS IAM Role"
}
