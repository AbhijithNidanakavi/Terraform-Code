/*
resource "aws_instance" "week13-worker-vm" {
  ami           = "ami-0168b9285893a7395"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.week13-pri-a.id
  vpc_security_group_ids = [aws_security_group.private-sg.id
  ]
  key_name = "ECE592.pem"
  user_data = file("cloudinit.txt")

  tags = {
    Name = "week13-worker-vm"
  }
  iam_instance_profile = aws_iam_instance_profile.week13-profile.name
}

resource "aws_iam_instance_profile" "week13-profile" {
  name = "week13-profile"
  role = aws_iam_role.week13-role.name
  tags = {}
}
*/
