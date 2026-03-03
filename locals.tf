locals {
  # Generate the full name combining prefix and environment
  full_resource_name = "${var.name_prefix}-${var.environment}"
  
  # Compute address names dynamically
  address_names = [
    for i in range(var.addresses_count) : 
    "${local.full_resource_name}-address-${i + 1}"
  ]
}
