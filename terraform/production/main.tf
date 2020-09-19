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
