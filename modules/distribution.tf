resource "aws_cloudfront_distribution" "idarth-cloudfront-distr" {
    
  origin {
    domain_name = "${aws_s3_bucket.idarth-static-site-host.bucket_regional_domain_name}"
    origin_id   = "${local.s3_origin_id}"
    
    /*s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
    }*/
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  /*logging_config {
    include_cookies = false
    bucket          = "mylogs.s3.amazonaws.com"
    prefix          = "myprefix"
  }*/

  aliases = ["${var.domain_name}", "www.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    compress = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  #price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }


    tags = {
        Project = "${var.name}-${var.env}"
        Scope    = "personal-blog"
  }
}