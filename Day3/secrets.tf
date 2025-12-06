resource "random_password" "secret_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>?"
}

resource "aws_secretsmanager_secret" "my_secret_password" {
  name = "my_secret_password"
}
resource "aws_secretsmanager_secret_version" "my_secret_password-version" {
  secret_id     = aws_secretsmanager_secret.my_secret_password.id
  secret_string = random_password.secret_password.result
}
