
#Call VPC Module First to get the Subnet IDs
# module "elearning-vpc" {
#     source      = "../vpc"

#     ENVIRONMENT = var.ENVIRONMENT
#     AWS_REGION  = var.AWS_REGION
# }

#RDS Parameters
resource "aws_db_parameter_group" "elearning-mariadb-parameters" {
  name        = "elearning-mariadb-parameters"
  family      = "mariadb10.6"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"

  }
  parameter {
    name  = "require_secure_transport"
    value = "0" # enable require_secure_transport
  }
}

#Define Subnet Group for RDS Service

resource "aws_db_subnet_group" "elearning-rds-subnet-group" {
  name        = "elearning-db-subnet"
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = [var.vpc_private_subnet1, var.vpc_private_subnet2, var.vpc_private_subnet3]
  tags = {
    Name = "${var.ENVIRONMENT}_elearning_db_subnet"
  }
}

#Define Security Groups for RDS Instances
resource "aws_security_group" "elearning-rds-sg" {

  name        = "elearning-rds-sg"
  description = "Created by Elearning"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.RDS_CIDR}"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ENVIRONMENT}-elearning-rds-sg"
  }
}

resource "aws_db_instance" "elearning-rds" {

  identifier              = var.ELEARNING_RDS_IDENTIFIER
  name                    = var.ELEARNING_RDS_DB_NAME
  allocated_storage       = var.ELEARNING_RDS_ALLOCATED_STORAGE
  storage_type            = "gp2"
  engine                  = var.ELEARNING_RDS_ENGINE
  engine_version          = var.ELEARNING_RDS_ENGINE_VERSION
  instance_class          = var.DB_INSTANCE_CLASS
  backup_retention_period = var.BACKUP_RETENTION_PERIOD
  publicly_accessible     = var.PUBLICLY_ACCESSIBLE
  username                = var.ELEARNING_RDS_USERNAME
  password                = var.ELEARNING_RDS_PASSWORD
  vpc_security_group_ids  = [aws_security_group.elearning-rds-sg.id]
  db_subnet_group_name    = aws_db_subnet_group.elearning-rds-subnet-group.name
  skip_final_snapshot     = true
  parameter_group_name    = aws_db_parameter_group.elearning-mariadb-parameters.name
  multi_az                = "false"

}

output "rds_prod_endpoint" {
  value = aws_db_instance.elearning-rds.address
}
output "rds_prod_port" {
  value = aws_db_instance.elearning-rds.port
}

output "rds_prod_user" {
  value = aws_db_instance.elearning-rds.username
}

