resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "aws_secretsmanager_secret" "private" {
  name = "private_key"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id = "${aws_secretsmanager_secret.private.id}"
  secret_string = "${tls_private_key.example.private_key_pem}"

  provisioner "local-exec" {
    command = "aws secretsmanager get-secret-value --secret-id private_key --profile default --region us-east-1"
    interpreter = ["/bin/bash", "-c"]
  }
}
 
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${tls_private_key.example.public_key_openssh}"
}

 