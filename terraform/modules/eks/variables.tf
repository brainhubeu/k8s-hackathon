variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "eks_subnet_ids" {
  type = list(string)
}

variable "worker_subnet_ids" {
  type = list(string)
}
