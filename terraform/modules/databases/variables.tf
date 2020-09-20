variable "vpc_id" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "ingress_cidr_blocks" {
  type = list(string)
}
