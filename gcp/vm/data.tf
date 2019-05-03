resource "random_shuffle" "default" {
  input        = ["${var.subnetworks}"]
  result_count = 1
}

data "google_compute_zones" "available" {}

data "google_compute_image" "default" {
    name = "${var.instance_image}"
    project = "${var.instance_project}"
}

data "google_compute_subnetwork" "default" {
    self_link = "${element(var.subnetworks, 0)}"
}

data "google_service_account" "custom-service-account" {
    count = "${var.service_account_id != "" ? 1 : 0}"
    account_id = "${var.service_account_id}"
}

data "google_compute_default_service_account" "defaut-service-account" {
    count = "${var.service_account_id == "" ? 1 : 0}"
}