data "aws_ami" "ubuntu" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "allow_ssh" {
  description = "Allow ssh"
  vpc_id      = "${aws_vpc.myvpc.id}"

  ingress {
    from_port   = 22        
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public-proxy_1" {
  ami = "${data.aws_ami.ubuntu.subnet_id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_1}"
  vpc_security_group_ids = "${aws_security_group.allow_ssh.id}"
  key-name = "${aws_key_pair.deployer}"
}

resource "aws_instance" "public-proxy_2" {
  ami = "${data.aws_ami.ubuntu.subnet_id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_2}"
  vpc_security_group_ids = "${aws_security_group.allow_ssh.id}"
  key-name = "${aws_key_pair.deployer}"
}

resource "aws_instance" "bastion" {
  ami = "${data.aws_ami.ubuntu.subnet_id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_1}"
  vpc_security_group_ids = "${aws_security_group.allow_ssh.id}"
  key-name = "${aws_key_pair.deployer}"
}

resource "aws_instance" "private-proxy_1" {
  ami = "${data.aws_ami.ubuntu.subnet_id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private_subnet_1}"
  vpc_security_group_ids = "${aws_security_group.allow_ssh.id}"
  key-name = "${aws_key_pair.deployer}"
}

resource "aws_instance" "private-proxy_1" {
  ami = "${data.aws_ami.ubuntu.subnet_id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private_subnet_2}"
  vpc_security_group_ids = "${aws_security_group.allow_ssh.id}"
  key-name = "${aws_key_pair.deployer}"
}