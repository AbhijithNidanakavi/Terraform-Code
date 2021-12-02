resource "aws_security_group" "week13-https-sg" {
  name        = "week13-https-sg"
  description = "AllowSSHinboundtraffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description = "https from vpc"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [aws_vpc.main.cidr_block]

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
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
    Name = "week13-https-sg"
  }
}

