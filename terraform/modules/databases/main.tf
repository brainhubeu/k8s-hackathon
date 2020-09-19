resource "random_password" "content_db_password" {
  length = 16
  special = true
  override_special = "!#$%^&*()-_+={}[]:;',.<>?"
}

module "content_db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.18.0"

  identifier = "content-db"
  name = "contentdb"

  subnet_ids = var.db_subnet_ids
  vpc_security_group_ids = [module.content_db_security_group.this_security_group_id]

  engine            = "postgres"
  engine_version    = "11.7"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  storage_encrypted = false

  family = "postgres11"
  major_engine_version = "11"

  username = "content_db_user"
  password = random_password.content_db_password.result
  port     = "5432"

  backup_retention_period = 7
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  final_snapshot_identifier = "content-db"
  deletion_protection = true
}

