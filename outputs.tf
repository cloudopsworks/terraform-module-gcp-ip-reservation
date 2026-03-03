##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "public_ip_ids" {
  description = "Map of reserved IP addresses (name => id)"
  value       = { for addr in google_compute_address.ip_reservation : addr.name => addr.id }
}

output "public_ips" {
  description = "List of reserved IP addresses"
  value       = google_compute_address.ip_reservation[*].address
}

output "reservation_number" {
  description = "Number of reserved IP addresses"
  value       = var.reservation_number
}

output "region" {
  description = "Region where IPs were reserved"
  value       = var.ip_settings.region != null ? var.ip_settings.region : data.google_client_config.current.region
}

output "ip_version" {
  description = "IP version of reserved addresses"
  value       = var.ip_settings.ip_version
}

output "address_type" {
  description = "Type of addresses (INTERNAL/EXTERNAL)"
  value       = var.ip_settings.address_type
}
