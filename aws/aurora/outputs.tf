output "generated_db_password" {
  description = "The automatic generated DB password"
  value       = "${random_id.password.b64}"
}
