variable "env" {
    description = "The environment it will serve (prod, staging, etc)"
    type = "string"
}

variable "project_name" {
    description = "GCP project name"
    type = "string"
}

variable "region" {
    description = "GCP region"
    default = "us-central1"
}

variable "instance_count" {
    description = "Number of instances to create"
    default = 1
}

variable "instance_name" {
    description = "The name to give to this instance"
    type = "string"
}

variable "instance_type" {
    description = "GCP Compute Instance type"
    type = "string"
    default = "n1-standard-1"
}

variable "instance_image" {
    description = "GCP Compute image to boot the instance"
    type = "string"
    default = "centos-7-v20190423"
}

variable "instance_project" {
    description = "GCP project where compute image resides"
    type = "string"
    default = "centos-cloud"
}

variable "subnetworks" {
    description = "GCP VPC subnetwork list to be randomized when creating instances"
    type = "list"
}

variable "create_data_volumes" {
  description = "Whether or not to create additional data disks (GCP Compute PD)"
  default     = false
}

variable "data_volume_size" {
  description = "If creating an additional disk, specify the size for it"
  default     = 50
}

variable "data_volume_type" {
  description = "If creating an additional disk, specify the type for it"
  type        = "string"
  default     = "pd-ssd"
}

variable "static_public_ip" {
  description = "Whether or not to create (and attach) an external static IP"
  default     = false
}