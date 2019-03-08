resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.default.id}"
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    "Name" = "${var.vpcprefix}-default-sg"
  }
}

resource "aws_security_group" "sec_bastion" {
  name        = "${var.vpcprefix}-bastion-sg"
  description = "Used for bastion instance"
  vpc_id      = "${aws_vpc.default.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
  tags {
    "Name" = "${var.vpcprefix}-bastion-sg"
  }
}
