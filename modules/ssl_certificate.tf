resource "aws_acm_certificate" "idarth-ssl-certificate" {
  domain_name       = "${var.domain_name}"
  subject_alternative_names = "${var.domain_name_www}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
        Project = "${var.name}-${var.env}"
        Scope    = "personal-blog"
    }
}