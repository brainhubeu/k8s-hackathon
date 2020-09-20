data "aws_caller_identity" "current" {}

locals {
  oidc_provider = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
}

resource "aws_iam_role" "external_dns" {
  name = "external_dns_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${local.oidc_provider}:sub": "system:serviceaccount:external-dns:external-dns"
        }
      }
    }
  ]
}
  EOF

}

resource "aws_iam_role_policy" "external_dns" {
  name = "external_dns_policy"
  role = aws_iam_role.external_dns.id

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
  EOF
}
