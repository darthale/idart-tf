resource "aws_s3_bucket" "idarth-static-site-host" {
  bucket = "${var.static_hosting_bucket}"
  acl    = "private"
  region = "${var.region}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  cors_rule {
    allowed_origins = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_headers = ["Authorization", "Content-Length"]
    max_age_seconds = 3000 

  }

  tags = {
    Project = "${var.name}-${var.env}"
    Scope    = "personal-blog"
  }
}