resource "aws_security_group" "week13-rds-sg" {
  name        = "week13-rds-sg"
  description = "AllowSSHinboundtraffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description = "SSH from VPC"
      from_port   = 22
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

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
    Name = "week13-rds-sg"
  }
}
