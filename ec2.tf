data "aws_ami" "latest-amazon-ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "week9-bastion-vm" {
  ami           = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.week_9_us_east_1a.id
  vpc_security_group_ids = [aws_security_group.week9.id]
  key_name = "ECE592.pem"

  tags = {
    Name = "week9-bastion-vm"
  }
}






