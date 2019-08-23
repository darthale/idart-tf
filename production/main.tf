terraform {
  backend s3 {}
}

data "terraform_remote_state" "state" {
  backend = "s3"

  config {
    bucket = "${var.state_bucket}"
    key    = "${var.state_file}"
    region = "${var.region}"
  }
}

provider "aws" {
  region = "${var.region}"
}
