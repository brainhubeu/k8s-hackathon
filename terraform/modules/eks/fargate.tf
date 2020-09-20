module "eks_fargate_profile" {
  source = "git::https://github.com/cloudposse/terraform-aws-eks-fargate-profile.git?ref=tags/0.5.0"

  name                 = "fargate-profile"
  kubernetes_namespace = "fargate-launch"
  subnet_ids           = var.worker_subnet_ids
  cluster_name         = module.eks.cluster_id
}
