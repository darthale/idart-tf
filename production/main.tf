terraform {
  backend s3 {
    bucket = "${var.state_bucket}"
    key    = "${var.state_file}"
    region = "${var.region}"
  }
}

/*data "terraform_remote_state" "state" {
  backend = "s3"

  config = {
    bucket = "${var.state_bucket}"
    key    = "${var.state_file}"
    region = "${var.region}"
  }
}*/

provider "aws" {
  region = "${var.region}"
}


module "infrastructure" {
  source = "../modules"
  
  region = "${var.region}"
  env = "${var.env}"
  name = "${var.name}"
  country = "${var.country}"
  state_bucket = "${var.state_bucket}"
  state_file = "${var.state_file}"
  static_hosting_bucket = "${var.static_hosting_bucket}"
  domain_name = "${var.domain_name}"
  domain_name_www = "${var.domain_name_www}"  
}

