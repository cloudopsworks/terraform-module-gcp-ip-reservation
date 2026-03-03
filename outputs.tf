output "addresses" {
  description = "Map of reserved IP addresses (name => address)"
  value       = { for addr in google_compute_address.addresses : addr.name => addr.address }
}

output "addresses_list" {
  description = "List of reserved IP addresses"
  value       = google_compute_address.addresses[*].address
}

output "addresses_count" {
  description = "Number of reserved IP addresses"
  value       = var.addresses_count
}

output "region" {
  description = "Region where IPs were reserved"
  value       = var.region
}

output "ip_version" {
  description = "IP version of reserved addresses"
  value       = var.ip_version
}

output "address_type" {
  description = "Type of addresses (INTERNAL/EXTERNAL)"
  value       = var.address_type
}
