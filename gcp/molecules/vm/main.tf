locals {
  service_account_email = coalesce(
    data.google_service_account.custom.*.email,
    data.google_compute_default_service_account.defaut.*.email,
  )
}

resource "google_compute_address" "default" {
  count = var.static_public_ip ? var.instance_count : 0

  name = "${var.environment}-${var.instance_name}-${count.index}"
}

resource "google_compute_instance" "no_external" {
  count = !var.static_public_ip ? var.instance_count : 0

  name         = "${var.environment}-${var.instance_name}-${count.index}"
  machine_type = var.instance_type
  zone         = element(random_shuffle.compute_zones.result, 0)

  boot_disk {
    initialize_params {
      image = data.google_compute_image.default.self_link
    }
  }

  network_interface {
    network    = data.google_compute_subnetwork.default.network
    subnetwork = element(random_shuffle.default.result, 0)

    # No external IP
  }

  service_account {
    email  = local.service_account_email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "external_ip" {
  count = var.static_public_ip ? var.instance_count : 0

  name         = "${var.environment}-${var.instance_name}-${count.index}"
  machine_type = var.instance_type
  zone         = element(random_shuffle.compute_zones.result, 0)

  boot_disk {
    initialize_params {
      image = data.google_compute_image.default.self_link
    }
  }

  network_interface {
    network    = data.google_compute_subnetwork.default.network
    subnetwork = element(random_shuffle.default.result, 0)

    access_config {
      nat_ip = element(google_compute_address.default.*.address, count.index)
    }
  }

  service_account {
    email  = local.service_account_email
    scopes = ["cloud-platform"]
  }

  depends_on = [google_compute_address.default]
}

resource "google_compute_disk" "data_disk" {
  count = var.create_data_volumes ? var.instance_count : 0

  name = "${var.environment}-${var.instance_name}-${count.index}-data-disk"

  zone = element(random_shuffle.compute_zones.result, 0)
  type = var.data_volume_type
  size = var.data_volume_size

  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "attachment" {
  count = var.create_data_volumes ? var.instance_count : 0

  device_name = "data-disk-${count.index}"

  disk = element(
    google_compute_disk.data_disk.*.self_link,
    count.index,
  )

  instance = element(
    concat(
      google_compute_instance.no_external.*.self_link,
      google_compute_instance.external_ip.*.self_link,
    ),
    count.index,
  )
}
