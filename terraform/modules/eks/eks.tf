module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.2.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.17"
  subnets         = var.eks_subnet_ids
  vpc_id          = var.vpc_id
  enable_irsa     = true

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 10
  }

  node_groups = {
    small = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_type = "t2.small"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
