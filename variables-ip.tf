##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# reservation_number: 1   # (Optional) Number of reserved IP addresses. Default: 1. Possible values: any positive integer (1, 2, 3, ...).
variable "reservation_number" {
  description = "(optional) Number of reserved IP addresses, defaults to 1"
  type        = number
  default     = 1
}

# ip_settings:   # (Optional) Map of settings for the IP address. Default: {}.
#   address_type: "EXTERNAL"   # (Optional) Type of address. Default: "EXTERNAL". Possible values: "EXTERNAL", "INTERNAL".
#     EXTERNAL: Public IP address accessible from the internet.
#     INTERNAL: Private IP address within a subnetwork.
#   ip_version: "IPV4"   # (Optional) IP version. Default: "IPV4". Possible values: "IPV4", "IPV6".
#   address: null   # (Optional) Specific static IP address to reserve. Default: null (auto-allocated).
#     When set, must be a valid IPv4 or IPv6 address string (e.g., "35.192.45.100" or "2001:db8::1").
#     If null, GCP automatically allocates an IP from the available pool.
#   subnetwork: null   # (Optional) Subnetwork for INTERNAL addresses. Default: null.
#     Format: "projects/{PROJECT_ID}/regions/{REGION}/subnetworks/{SUBNETWORK_NAME}"
#     Required when address_type is "INTERNAL". Ignored for "EXTERNAL" addresses.
#   description: null   # (Optional) Description for the reserved IP address. Default: null.
#     Free-form text description (max 256 characters).
#   region: null   # (Optional) Region for the IP reservation. Default: null (uses provider region).
#     GCP region name (e.g., "us-central1", "europe-west1", "asia-southeast1").
#     For EXTERNAL addresses, can be null to use global scope.
#     For INTERNAL addresses, must match the subnetwork region.
variable "ip_settings" {
  description = "(optional) Map of settings for the IP address"
  type = object({
    address_type = optional(string, "EXTERNAL")
    ip_version   = optional(string, "IPV4")
    address      = optional(string, null)
    subnetwork   = optional(string, null)
    description  = optional(string, null)
    region       = optional(string, null)
  })
  default = {}
}
