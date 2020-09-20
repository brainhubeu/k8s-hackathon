module "content_db" {
  source = "./content"

  vpc_id              = var.vpc_id
  db_subnet_ids       = var.db_subnet_ids
  ingress_cidr_blocks = var.ingress_cidr_blocks
}

module "keycloak_db" {
  source = "./keycloak"

  vpc_id              = var.vpc_id
  db_subnet_ids       = var.db_subnet_ids
  ingress_cidr_blocks = var.ingress_cidr_blocks
}
