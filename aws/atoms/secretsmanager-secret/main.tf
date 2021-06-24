resource "aws_secretsmanager_secret" "default" {
  count = var.create_secret ? 1 : 0

  name        = var.name
  description = var.description

  tags = var.tags
}

# When var.create_secret is false, read from the existing secret based on
# var.name
data "aws_secretsmanager_secret" "default" {
  count = var.create_secret ? 0 : 1

  name = var.name
}

locals {
  secretsmanager_secret = try(
    aws_secretsmanager_secret.default[0],
    data.aws_secretsmanager_secret.default[0],
  )
}

resource "aws_secretsmanager_secret_version" "default" {
  # Only try to create the secret version if the specified value is not empty
  count = (var.value != "" && var.create_secret) ? 1 : 0

  secret_id     = local.secretsmanager_secret.id
  secret_string = var.value
}
