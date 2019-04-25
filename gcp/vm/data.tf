resource "random_shuffle" "default" {
  input        = ["${var.subnetworks}"]
  result_count = 1
}

data "google_compute_zones" "available" {}

data "google_compute_image" "default" {
    name = "${var.instance_image}"
    project = "${var.instance_project}"
}