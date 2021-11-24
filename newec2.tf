resource "aws_instance" "week11-worker-vm" {
  ami           = "ami-0168b9285893a7395"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.week11-pri-a.id
  vpc_security_group_ids = [aws_security_group.private-sg.id
  ]
  key_name = "ECE592.pem"
  user_data = file("cloudinit.txt")

  tags = {
    Name = "week11-worker-vm"
  }
  iam_instance_profile = aws_iam_instance_profile.week11-profile.name
}

resource "aws_iam_instance_profile" "week11-profile" {
  name = "week11-profile"
  role = aws_iam_role.week11-role.name
  tags = {}
}

