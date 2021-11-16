resource "aws_instance" "week10-worker-vm" {
  ami           = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.week10-pri-a.id
  vpc_security_group_ids = [aws_security_group.private-sg.id
  ]
  key_name = "ECE592.pem"

  tags = {
    Name = "week10-worker-vm"
  }
  iam_instance_profile = aws_iam_instance_profile.week10-profile.name
}

resource "aws_iam_instance_profile" "week10-profile" {
  name = "week10-profile"
  role = aws_iam_role.week10-role.name
  tags = {}
}

