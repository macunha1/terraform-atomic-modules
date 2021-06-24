output "secret_id" {
  description = "Same as ARN but with a different name"
  value       = local.secretsmanager_secret.id
}

output "secret_arn" {
  description = "ARN (Amazon Resource Name) of the secret"
  value       = local.secretsmanager_secret.arn
}
