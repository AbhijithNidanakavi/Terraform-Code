resource "aws_vpc_endpoint" "week11-ec2-ep" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.week11-https-sg.id,
  ]
  subnet_ids        = [aws_subnet.week_11_us_east_1a.id,
                       aws_subnet.week_11_us_east_1b.id]

private_dns_enabled = true

tags = {
       Name = "week11-ec2-ep"
}

}
resource "aws_vpc_endpoint" "week11-sqs-ep" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.sqs"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.week11-https-sg.id,
  ]

  subnet_ids        = [aws_subnet.week_11_us_east_1a.id,
                       aws_subnet.week_11_us_east_1b.id]
private_dns_enabled = true

tags = {
       Name = "week11-sqs-ep"
  }
}

