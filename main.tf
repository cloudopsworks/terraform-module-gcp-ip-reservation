##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "google_compute_address" "ip_reservation" {
  count = var.reservation_number

  name         = local.address_names[count.index]
  address_type = var.ip_settings.address_type
  ip_version   = var.ip_settings.ip_version
  address      = var.ip_settings.address
  subnetwork   = var.ip_settings.subnetwork
  description  = var.ip_settings.description != null ? "${var.ip_settings.description} (${local.address_names[count.index]})" : null
  region       = var.ip_settings.region

  labels = local.all_tags

  lifecycle {
    create_before_destroy = true
  }
}
