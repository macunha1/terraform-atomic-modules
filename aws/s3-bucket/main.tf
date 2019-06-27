resource "random_id" "name" {
  byte_length = 8
}

resource "aws_s3_bucket" "current" {
  bucket = "${var.env}-${var.usage}-${random_id.name.hex}"
  acl    = "${var.public_acl ? "public-read" : "private"}"
  region = "${var.region_specific ? var.region : ""}"

  tags          =  {
    Name        = "Bucket for ${var.usage}"
    Environment = "${var.env}"
  }
}
