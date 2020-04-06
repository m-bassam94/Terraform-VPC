resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = "2048"
  provisioner "local-exec" {
    command = "echo ${tls_private_key.example.private_key.pem} >> private_key.pem"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${tls_private_key.example.public_key_openssh}"
}

