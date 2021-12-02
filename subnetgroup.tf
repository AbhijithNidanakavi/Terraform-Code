resource "aws_db_subnet_group" "week12-subnetgroup" {
  name       = "week12-subnetgroup"
  subnet_ids = [aws_subnet.week12-pri-a.id, aws_subnet.week12-pri-b.id]

  tags = {
    Name = "week12-subnetgroup"
  }
}
