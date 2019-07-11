resource "google_compute_network" "default" {
  name                    = "${var.env}-${var.project_name}-vpc"
  description             = "VPC for ${var.env} in ${var.project_name} - Automatic created by Terraform"
  auto_create_subnetworks = false
  routing_mode            = "${var.routing_mode}"
  project                 = "${var.project_name}"
}

resource "google_compute_subnetwork" "private" {
  depends_on = [
    "google_compute_network.default",
  ]

  count = "${var.subnet["private"]}"

  name = "${format("%v-%v-private-%02d-subnet",
                                       var.env,
                                       var.project_name,
                                       count.index+1)}"

  ip_cidr_range = "${cidrsubnet(var.cidr_block,
                                           var.subnet_cidr_bits,
                                           count.index)}"

  region                   = "${var.region}"
  private_ip_google_access = true
  network                  = "${google_compute_network.default.name}"
  project                  = "${var.project_name}"
}

resource "google_compute_router" "router" {
  name = "${format("%v-%v-private-router",
                   var.env,
                   var.project_name)}"

  region  = "${var.region}"
  network = "${google_compute_network.default.self_link}"

  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "nat_address" {
  count = "${var.create_nat_gateway ? 1 : 0}"

  name = "${format("%v-%v-nat-static-pubip",
                     var.env,
                     var.project_name)}"

  region = "${var.region}"
}

resource "google_compute_router_nat" "default" {
  depends_on = [
    "google_compute_address.nat_address",
    "google_compute_router.router",
  ]

  count = "${var.create_nat_gateway ? 1 : 0}"

  name = "${format("%v-%v-nat-router",
                     var.env,
                     var.project_name)}"

  router                             = "${google_compute_router.router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = ["${element(google_compute_address.nat_address.*.self_link, 0)}"]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_subnetwork" "public" {
  depends_on = [
    "google_compute_network.default",
  ]

  count = "${var.subnet["public"]}"

  name = "${format("%v-%v-public-%02d-subnet",
                                       var.env,
                                       var.project_name,
                                       count.index+1)}"

  ip_cidr_range = "${cidrsubnet(var.cidr_block,
                                           var.subnet_cidr_bits,
                                           count.index+127)}"

  region  = "${var.region}"
  network = "${google_compute_network.default.name}"
  project = "${var.project_name}"
}
