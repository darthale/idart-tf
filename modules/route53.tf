data "aws_route53_zone" "idarth-hosted-zone" {
  name = "${var.domain_name}."
}

resource "aws_route53_record" "idarth-record-domain" {
  zone_id = "${data.aws_route53_zone.idarth-hosted-zone.zone_id}"
  name = "${var.domain_name}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.idarth-cloudfront-distr.domain_name}"
    zone_id = "${aws_cloudfront_distribution.idarth-cloudfront-distr.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "idarth-record-domain-www" {
  zone_id = "${data.aws_route53_zone.idarth-hosted-zone.zone_id}"
  name = "${var.domain_name_www}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.idarth-cloudfront-distr.domain_name}"
    zone_id = "${aws_cloudfront_distribution.idarth-cloudfront-distr.hosted_zone_id}"
    evaluate_target_health = false
  }
}