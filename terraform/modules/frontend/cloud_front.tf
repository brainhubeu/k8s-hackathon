resource "aws_cloudfront_origin_access_identity" "cdn_bucket_origin" {
  comment = "cloudfront origin access identity"
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled     = true
  price_class = "PriceClass_100"
  aliases     = [local.domain]

  origin {
    domain_name = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
    origin_id   = local.domain

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cdn_bucket_origin.cloudfront_access_identity_path
    }
  }

  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.domain

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400

    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }
}
