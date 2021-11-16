data "aws_ami" "latest-amazon-ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "terraform_instance_hw" {
  ami           ="ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.automation_sub_a.id
  vpc_security_group_ids = [aws_security_group.week4.id
  ]
  key_name = "ECE592.pem"

  tags = {
    Name = "automation-vm"
  }

  iam_instance_profile = aws_iam_instance_profile.automation-profile.name
}

resource "aws_iam_instance_profile" "automation-profile" {
  name = "automation-profile"
  role = aws_iam_role.automation-role.name
  tags = {}
}
