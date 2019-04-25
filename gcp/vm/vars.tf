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
    type = "string"
}

variable "instance_type" {
    type = "string"
    default = "n1-standard-1"
}

variable "instance_image" {
    type = "string"
    default = "centos-7-v20190423"
}

variable "instance_project" {
    type = "string"
    default = "centos-cloud"
}

variable "network" {
    type = "string"
}

variable "subnetworks" {
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