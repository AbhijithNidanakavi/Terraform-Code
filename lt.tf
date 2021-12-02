resource "aws_launch_template" "week13-bastion-lt" {
  name = "week13-bastion-lt"

  image_id = "ami-02e136e904f3da870"

  instance_type = "t2.micro"

  key_name = "ECE592.pem"

  network_interfaces {
    security_groups = [aws_security_group.week13.id]
    subnet_id       = aws_subnet.week_13_us_east_1a.id
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "week13-bastion-vm"
    }
  }
}
