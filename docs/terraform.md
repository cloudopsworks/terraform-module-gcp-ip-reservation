## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.ip_reservation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_ip_settings"></a> [ip\_settings](#input\_ip\_settings) | (optional) Map of settings for the IP address | <pre>object({<br/>    address_type = optional(string, "EXTERNAL")<br/>    ip_version   = optional(string, "IPV4")<br/>    address      = optional(string, null)<br/>    subnetwork   = optional(string, null)<br/>    description  = optional(string, null)<br/>    region       = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_reservation_number"></a> [reservation\_number](#input\_reservation\_number) | (optional) Number of reserved IP addresses, defaults to 1 | `number` | `1` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_type"></a> [address\_type](#output\_address\_type) | Type of addresses (INTERNAL/EXTERNAL) |
| <a name="output_ip_version"></a> [ip\_version](#output\_ip\_version) | IP version of reserved addresses |
| <a name="output_public_ip_ids"></a> [public\_ip\_ids](#output\_public\_ip\_ids) | Map of reserved IP addresses (name => id) |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | List of reserved IP addresses |
| <a name="output_region"></a> [region](#output\_region) | Region where IPs were reserved |
| <a name="output_reservation_number"></a> [reservation\_number](#output\_reservation\_number) | Number of reserved IP addresses |
