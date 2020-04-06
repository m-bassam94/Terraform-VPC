variable "public_CIDR" {
  type    = "list"
  default = ["10.0.1.0/24", "10.0.1.0/24"]
}

variable "private_CIDR" {
  type    = "list"
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zone" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b"]
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ITI-VPC "
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.myvpc.id}"
  count             = "${length(var.public_CIDR)}"
  cidr_block        = "${element(var.public_CIDR, count.index)}"
  availability_zone = "${element(var.availability_zone, count.index)}"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${aws_vpc.myvpc.id}"
  count             = "${length(var.private_CIDR)}"
  cidr_block        = "${element(var.private_CIDR, count.index)}"
  availability_zone = "${element(var.availability_zone, count.index)}"
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table_association" "public_subnet_rt_association" {
  count          = "${length(var.public_CIDR)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_route_table_association" "private_subnet_rt_association" {
  count          = "${length(var.private_CIDR)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
