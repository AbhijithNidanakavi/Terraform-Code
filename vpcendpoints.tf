resource "aws_vpc_endpoint" "week13-sm-ep" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.secretsmanager"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.week13-https-sg.id,
  ]
  subnet_ids        = [aws_subnet.week13-pri-a.id,
                       aws_subnet.week13-pri-b.id]

private_dns_enabled = true

tags = {
       Name = "week13-sm-ep"
}
}
