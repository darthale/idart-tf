provider "aws" {
  alias           = "us_east_1"
  region          = "us-east-1"
}

data "aws_acm_certificate" "idarth-ssl-certificate" {
  provider        = "aws.us_east_1"
  domain  = "${var.domain_name}"
  statuses = ["ISSUED"]
}


resource "aws_cloudfront_distribution" "idarth-cloudfront-distr" {
    
  origin {
    domain_name = "${aws_s3_bucket.idarth-static-site-host.bucket_regional_domain_name}"
    origin_id   = "${var.domain_name}"
    
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

  aliases = ["${var.domain_name}", "${var.domain_name_www}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.domain_name}"

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
      restriction_type = "none"
      locations        = []
    }
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code = 403
    response_code = 404
    response_page_path = "/404.html"
  }

  viewer_certificate {
    
    acm_certificate_arn  = "${data.aws_acm_certificate.idarth-ssl-certificate.arn}"
    ssl_support_method  = "sni-only"
  }


    tags = {
        Project = "${var.name}-${var.env}"
        Scope    = "personal-blog"
    }
}