module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "12.2.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.17"
  subnets         = var.eks_subnet_ids
  vpc_id          = var.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
  ]
  worker_additional_security_group_ids = [
    aws_security_group.worker_group_mgmt_one.id
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
