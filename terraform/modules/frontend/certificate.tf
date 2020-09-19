resource "aws_acm_certificate" "cert" {
  provider = aws.us-east-1
  domain_name               = local.domain
  validation_method         = "DNS"
}

resource "aws_route53_record" "cert_record" {
  zone_id = var.zone_id
  name    = tolist(aws_acm_certificate.cert.domain_validation_options).0.resource_record_name
  type    = tolist(aws_acm_certificate.cert.domain_validation_options).0.resource_record_type
  records = [
    tolist(aws_acm_certificate.cert.domain_validation_options).0.resource_record_value
  ]
  ttl = 300
}
