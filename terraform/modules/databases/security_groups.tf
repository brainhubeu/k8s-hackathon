module "content_db_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/postgresql"
  version = "~> 3.0"

  name = "content-db-sg"
  vpc_id = var.vpc_id

  ingress_cidr_blocks = var.ingress_cidr_blocks
}
