resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.db_name_prefix}-subnet-group"
  subnet_ids  = var.private_subnet_ids
  description = "Subnet group for RDS instance in private subnets"

  tags = merge(var.tags, {
    Name = "${var.db_name_prefix}-subnet-group"
  })
}

resource "aws_security_group" "rds_sg" {
  name_prefix = "${var.db_name_prefix}-sg-"
  vpc_id      = var.vpc_id
  description = "Security group for RDS instance"

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.db_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.db_name_prefix}-sg"
  })
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  identifier           = var.db_identifier
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az             = var.db_multi_az
  publicly_accessible  = false
  skip_final_snapshot  = var.db_skip_final_snapshot
  final_snapshot_identifier = var.db_final_snapshot_identifier

  tags = merge(var.tags, {
    Name = var.db_identifier
  })
}