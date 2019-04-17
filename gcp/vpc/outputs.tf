output "id" {
  description = "GCP VPC Id"
  value       = "${google_compute_network.default.self_link}"
}

output "private_subnets" {
  description = "List of private subnets"
  value       = "${google_compute_subnetwork.private.*.self_link}"
}

output "public_subnets" {
  description = "List of public subnets"
  value       = "${google_compute_subnetwork.public.*.self_link}"
}

output "environment" {
  description = "Environment name for this module"
  value = "${var.env}"
}

output "project_name" {
  description = "Project name that this VPC serves"
  value       = "${var.project_name}"
}
