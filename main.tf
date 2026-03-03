# GCP Static IP Address Reservation
resource "google_compute_address" "addresses" {
  count = var.addresses_count

  name         = local.address_names[count.index]
  address_type = var.address_type
  ip_version   = var.ip_version
  address      = var.address
  subnetwork   = var.subnet
  description  = var.description != null ? "${var.description} (${local.address_names[count.index]})" : null

  labels = var.labels

  lifecycle {
    create_before_destroy = true
  }
}
