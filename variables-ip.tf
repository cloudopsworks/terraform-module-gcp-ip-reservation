# GCP IP-specific configuration variables
variable "address_type" {
  description = "Type of address: INTERNAL or EXTERNAL"
  type        = string
  default     = "EXTERNAL"
  validation {
    condition     = contains(["INTERNAL", "EXTERNAL"], var.address_type)
    error_message = "address_type must be either INTERNAL or EXTERNAL."
  }
}

variable "ip_version" {
  description = "IP version: IPV4 or IPV6"
  type        = string
  default     = "IPV4"
  validation {
    condition     = contains(["IPV4", "IPV6"], var.ip_version)
    error_message = "ip_version must be either IPV4 or IPV6."
  }
}

variable "address" {
  description = "The static IP address to reserve (leave empty for dynamic allocation)"
  type        = string
  default     = null
}

variable "subnet" {
  description = "Subnetwork within which to reserve the IP range (for internal addresses)"
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the reserved IP address"
  type        = string
  default     = null
}

variable "addresses_count" {
  description = "Number of IP addresses to reserve"
  type        = number
  default     = 1
  validation {
    condition     = var.addresses_count >= 1
    error_message = "addresses_count must be greater than or equal to 1."
  }
}
