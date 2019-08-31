resource "aws_instance" "demoinstance-newvpc" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # The VPC Subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # The Security Group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # The Public SSH Key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}
