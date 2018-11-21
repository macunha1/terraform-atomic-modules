variable "project_name" {
  description = "The project name that this VPC will serve"
  type        = "string"
}

variable "instance_of" {
  description = "The name to give to this instance"
  type        = "string"
}

variable "instance_count" {
  description = "Number of instancesa to create with this template"
  default     = 1
}

variable "instance_size" {
  description = "AWS Ec2 Instance size"
  type        = "string"
  default     = "t2.micro"
}

variable "subnets" {
  description = "AWS VPC Subnets to randomize over"
}

variable "env" {
  description = "The environment it will serve (prod, staging, etc)"

  type = "string"
}

variable "use_public_subnet" {
  description = "Whether or not to create public resources (like EIP and a FQDN)"
}

variable "static_public_ip" {
  description = "Whether or not to create (and attach) an Elastic IP"
  default     = false
}

variable "ami_info" {
  description = "Map of configurations for the AWS Ec2 AMI"
  type        = "map"
}

variable "instance_user_data" {
  description = "Instance UserData (commands to be executed in the Ec2 startup)"
  type        = "string"
  default     = ""
}

variable "instance_profile" {
  description = "Instance AWS IAM profile (if it should use some role)"
  type        = "string"
  default     = ""
}

variable "custom_tags" {
  description = "Custom tags to append to this instance"
  type        = "map"
  default     = {}
}

variable "create_data_volumes" {
  description = "Whether or not to create additional data disks (AWS EBS)"
  default     = false
}

variable "data_volume_size" {
  description = "If creating an additional disk, specify the size for it"
  default     = 50
}

variable "data_volume_type" {
  description = "If creating an additional disk, specify the type for it"
  type        = "string"
  default     = "standard"
}

/* TODO: Create hosted zone in the Route 53
variable "fqdn_ttl_in_dns" {
  description = "Default FQDN entry TTL in the DNS"
  default     = 3600
}

variable "create_fqdn" {
  description = "Whether or not to create a FQDN entry for this instance"
}
*/

