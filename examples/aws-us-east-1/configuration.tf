terraform {
  backend "s3" {
    bucket = "some-state-bucket"
    key    = "aws-us-east-1/"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
