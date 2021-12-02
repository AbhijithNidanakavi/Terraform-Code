resource "aws_rds_cluster" "week12-rds" {
  cluster_identifier   = "week12-rds"
  database_name        = "week12_rds"
  engine               = "aurora-mysql"
  engine_mode          = "serverless"
  master_password      = "secret123"
  master_username      = "admin"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.week12-subnetgroup.name
  vpc_security_group_ids =[aws_security_group.week12-rds-sg.id]

scaling_configuration{
auto_pause             = true
min_capacity           = 1
max_capacity           = 2
seconds_until_auto_pause = 300
 }
}
output "week12-rds-endpoint" { 
  value = aws_rds_cluster.week12-rds.endpoint 
}
