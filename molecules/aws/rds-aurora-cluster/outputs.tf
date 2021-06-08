output "database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aws_rds_cluster_aurora.this_rds_cluster_database_name
}

output "master_password" {
  description = "Master/Root password for the RDS cluster"
  value       = module.aws_rds_cluster_aurora.this_rds_cluster_master_password
  sensitive   = true
}

output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aws_rds_cluster_aurora.this_security_group_id
}

output "arn" {
  description = "The ID of the cluster"
  value       = module.aws_rds_cluster_aurora.this_rds_cluster_arn
}

output "id" {
  description = "The ID of the cluster"
  value       = module.aws_rds_cluster_aurora.this_rds_cluster_id
}

output "resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.aws_rds_cluster_aurora.this_rds_cluster_resource_id
}

output "endpoint" {
  description = "The cluster endpoint"
  value       = module.aws_rds_cluster_aurora.this_rds_cluster_endpoint
}
