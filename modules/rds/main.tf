resource "aws_db_subnet_group" "this" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "${var.rds_tag_name}-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  db_name              = var.rds_db
  username             = var.rds_db_user
  password             = var.rds_db_pass
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot  = true
  tags = {
    Name = "${var.rds_tag_name}"
  }
}