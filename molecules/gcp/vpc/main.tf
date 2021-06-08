resource "google_compute_network" "default" {
  name         = "${var.environment}-${var.project_name}-vpc"
  description  = "VPC for ${var.environment} in ${var.project_name} - Automatic created by Terraform"
  routing_mode = var.routing_mode
  project      = var.project_name

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  count = var.subnet["private"]

  name = format("%v-%v-private-%02d-subnet",
    var.environment,
    var.project_name,
    count.index + 1
  )

  region  = var.region
  network = google_compute_network.default.name
  project = var.project_name

  ip_cidr_range = cidrsubnet(
    var.cidr_block,
    var.subnet_cidr_bits,
    count.index
  )

  private_ip_google_access = true

  depends_on = [google_compute_network.default]
}

resource "google_compute_router" "router" {
  name = format(
    "%v-%v-private-router",
    var.environment,
    var.project_name,
  )

  region  = var.region
  network = google_compute_network.default.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "nat_address" {
  count = var.create_nat_gateway ? 1 : 0

  name = format(
    "%v-%v-nat-static-pubip",
    var.environment,
    var.project_name
  )

  region = var.region
}

resource "google_compute_router_nat" "default" {
  count = var.create_nat_gateway ? 1 : 0

  name = format("%v-%v-nat-router",
    var.environment,
  var.project_name)

  router  = google_compute_router.router.name
  region  = var.region
  nat_ips = google_compute_address.nat_address.*.self_link

  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  depends_on = [
    google_compute_address.nat_address,
    google_compute_router.router,
  ]
}

resource "google_compute_subnetwork" "public" {
  count = var.subnet["public"]

  name = format(
    "%v-%v-public-%02d-subnet",
    var.environment,
    var.project_name,
    count.index + 1,
  )

  region  = var.region
  network = google_compute_network.default.name
  project = var.project_name

  ip_cidr_range = cidrsubnet(
    var.cidr_block,
    var.subnet_cidr_bits,
    count.index + 127,
  )

  depends_on = [google_compute_network.default]
}
