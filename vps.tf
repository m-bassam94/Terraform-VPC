resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${var.subnet_public_1}"
  availability_zone = "${var.availability_zone_1}"
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${var.subnet_public_2}"
  availability_zone = "${var.availability_zone_2}"
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${var.subnet_private_1}"
  availability_zone = "${var.availability_zone_1}"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${var.subnet_private_2}"
  availability_zone = "${var.availability_zone_2}"
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table_association" "public_subnet_1_rt_association" {
  subnet_id      = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "public_subnet_2_rt_association" {
  subnet_id      = "${aws_subnet.public_subnet_2.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_route_table_association" "private_subnet_1_rt_association" {
  subnet_id      = "${aws_subnet.private_subnet_1.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
resource "aws_route_table_association" "private_subnet_2_rt_association" {
  subnet_id      = "${aws_subnet.private_subnet_2.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
