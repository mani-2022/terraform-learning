data "aws_secretsmanager_secret" "my_secret_password" {
  name = "my_secret_password"
}
data "aws_secretsmanager_secret_version" "my_secret_password-version" {
  secret_id = data.aws_secretsmanager_secret.my_secret_password.id
}
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my_db_subnet_group"
  subnet_ids = [aws_subnet.my_subnet1.id, aws_subnet.my_subnet2.id]

  tags = {
    Name = "my_db_subnet_group"
  }
}

resource "aws_db_instance" "MyDatabase" {
  identifier           = "mydatabase-instance"
  allocated_storage    = 10
  db_name              = "mydatabase"
  engine               = "mysql"
  engine_version       = "8.0.43"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = data.aws_secretsmanager_secret_version.my_secret_password-version.secret_string
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.id
  tags = {
    Name = "MyDatabase"
  }
}
