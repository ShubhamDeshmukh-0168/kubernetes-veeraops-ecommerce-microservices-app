resource "aws_db_subnet_group" "sd_sub_grp" {

  name = "sd-db-subnet-group"

  subnet_ids = [
    aws_subnet.sd_private1.id,
    aws_subnet.sd_private2.id
  ]

  tags = {
    Name = "sd-db-subnet-group"
  }
}

resource "aws_db_instance" "sd_rds" {

  allocated_storage = 20

  identifier = "sd-microservices-rds"

  db_subnet_group_name = aws_db_subnet_group.sd_sub_grp.name

  engine         = "mysql"
  engine_version = "8.4.8"

  instance_class = "db.t3.micro"

  multi_az = true

  db_name  = "mydb"
  username = "admin"
  password = "Cloud123"

  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.sd_allow_all.id
  ]

  publicly_accessible   = true
  backup_retention_period = 7

  depends_on = [
    aws_db_subnet_group.sd_sub_grp
  ]

  tags = {
    Name = "sd-book-rds"
  }
}