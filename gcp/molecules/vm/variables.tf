variable "environment" {
  description = "To which environment does this VM belongs to?"
  type        = string
}

variable "project_name" {
  description = "GCP project name"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "subnetworks" {
  description = "GCP VPC subnetwork list to be randomized when creating instances"
  type        = list(string)
}

variable "instance_name" {
  description = "The name to give to this instance"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "GCP Compute Instance type"
  type        = string
  default     = "n1-standard-1"
}

variable "instance_image" {
  description = "GCP Compute image to boot the instance"
  type        = string
  default     = "centos-7-v20190423"
}

variable "instance_project" {
  description = "GCP project where compute image resides"
  type        = string
  default     = "centos-cloud"
}

variable "create_data_volumes" {
  description = "Whether or not to create additional data disks (GCP Compute PD)"
  type        = bool
  default     = false
}

variable "data_volume_size" {
  description = "If creating an additional disk, specify the size for it"
  type        = number
  default     = 50
}

variable "data_volume_type" {
  description = "If creating an additional disk, specify the type for it"
  type        = string
  default     = "pd-ssd"
}

variable "static_public_ip" {
  description = "Whether or not to create (and attach) an external static IP"
  type        = bool
  default     = false
}

variable "service_account_id" {
  description = "GCE Service Account ID to apply on all instances. Will fallback to default service account if empty"
  type        = string
  default     = ""
}
