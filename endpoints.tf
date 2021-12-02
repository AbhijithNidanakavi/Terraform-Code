/*
resource "aws_security_group" "week12-https-sg" {
  name        = "week12-https-sg"
  description = "AllowSSHinboundtraffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description = "SSH from VPC"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = []

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.private-sg.id]
      self             = false
    }
  ]

  egress = [
    {
      description = "Allow all outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]


      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "week12-https-sg"
  }
}

*/
