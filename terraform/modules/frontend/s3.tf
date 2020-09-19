resource "aws_s3_bucket" "frontend_bucket" {
  bucket = local.domain

  website {
    index_document = "index.html"
  }

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "OnlyCloudfrontReadAccess",
        "Principal": {
          "AWS": "${aws_cloudfront_origin_access_identity.cdn_bucket_origin.iam_arn}"
        },
        "Effect": "Allow",
        "Action": [
          "s3:GetObject"
        ],
        "Resource": "arn:aws:s3:::${local.domain}/*"
      }
    ]
  }
  EOF
}

resource "aws_s3_bucket_public_access_block" "frontend_bucket_public_access_block" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
