resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "aws_secretsmanager_secret" "private" {
  name = "private_key_v2"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = "${aws_secretsmanager_secret.private.id}"
  secret_string = "${tls_private_key.example.private_key_pem}"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${tls_private_key.example.public_key_openssh}"
}

output "private_key" {
  value = "${tls_private_key.example.private_key_pem}"
}

