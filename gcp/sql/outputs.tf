output "id" {
  description = "The Cloud SQL instance self-link URI identification"
  value       = "${google_sql_database_instance.default.self_link}"
}

output "ip_address" { 
  description = "The Cloud SQL instance IP address configured"
  value       = "${google_sql_database_instance.default.ip_address.0.ip_address}"
}
