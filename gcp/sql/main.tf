resource "google_sql_database_instance" "default" {
  name             = "${var.env}-${var.instance_of}"

  region           = "${var.region}"
  database_version = "${var.database_engine}"
  project          = "${var.project_name}"

  settings {
    tier = "${var.database_instance_type}"
    
    availability_type = "${var.use_multi_az ? "REGIONAL" : "ZONAL"}"
    disk_size         = "${var.database_storage_size}"
    ip_configuration {
      ipv4_enabled    = true
      private_network = "${var.vpc_network}"
    }
  }
}
