terraform {
  backend "s3" {
    bucket = "k8s-hackathon-terraform"
    key    = "production.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "default"
  alias   = "us-east-1"
  region  = "us-east-1"
}

module "route53" {
  source = "../modules/route53"
}

module "frontend" {
  source = "../modules/frontend"

  zone_id = module.route53.zone_id
  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "k8s-hackathon-vpc"
  cidr = "10.0.0.0/16"

  azs                 = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
  elasticache_subnets = ["10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24"]

  enable_nat_gateway = true
}
