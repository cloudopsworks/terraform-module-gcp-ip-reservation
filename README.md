# Terraform GCP IP Reservation Module

This Terraform module is designed to manage Google Cloud Platform (GCP) static IP address reservations. It provides a simple and reusable way to allocate and reserve static IPs with GCP resources such as compute instances, load balancers, and more. The module includes the following features:

- Allocation of static IP addresses (INTERNAL or EXTERNAL)
- Support for IPv4 and IPv6
- Bulk IP reservation capability
- Support for labeling resources
- Conditional creation of resources based on input variables
- Integration with other GCP services and resources
- Consistent tagging and organizational standards based on Cloud Ops Works practices

The module is intended to be used as part of a larger infrastructure setup, allowing for easy management and reservation of static IPs within your GCP environment.

## Introduction

This module simplifies the process of reserving and managing GCP static IP addresses. It allows for bulk allocation and easy integration with other GCP resources, all while maintaining consistent labeling and organizational standards.

## AWS vs GCP IP Reservation Comparison

### AWS Resources (terraform-module-aws-eip-reservation)
- **Resource**: `aws_eip` - Elastic IP
- **Key Features**:
  - Domain (vpc/standard)
  - Specific IP address selection
  - Direct association with EC2 instances or network interfaces
  - IPv4 pool selection
  - IPAM pool integration
  - Customer-owned IPv4 pools

### GCP Equivalent Resources
- **Resource**: `google_compute_address` - Static IP Address
- **Equivalent Features**:
  - Address type (INTERNAL/EXTERNAL) ↔ AWS domain
  - Specific IP address selection ↔ AWS ip_address
  - Region-level reservation (global for external)
  - IP version (IPv4/IPv6)
  - Subnetwork association for internal IPs
  - Labels (GCP equivalent of tags)

### Key Differences
1. **Association**: AWS EIP can be directly associated with instances/NICs; GCP requires separate forwarding rules or instance configuration
2. **Scope**: AWS EIP is regional; GCP external IPs can be global, internal are regional
3. **Tagging**: AWS uses tags; GCP uses labels
4. **Pools**: AWS has public/customer-owned/IPAM pools; GCP uses project-level allocation

## Usage

**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases. Instead pin to the release tag (e.g. `?ref=vX.Y.Z`) of one of our latest releases.

To use this module within a Terragrunt configuration, include it in your `terragrunt.hcl` file:

```hcl
terraform {
  source = "github.com/cloudopsworks/terraform-module-gcp-ip-reservation.git?ref=v1.0.0"
}

inputs = {
  reservation_number = 1   # (Optional) Number of reserved IP addresses. Default is 1.
  ip_settings = {   # (Optional) Map of settings for the IP address.
    address_type = "EXTERNAL"   # (Optional) Type of address: INTERNAL or EXTERNAL. Default is "EXTERNAL".
    ip_version   = "IPV4"       # (Optional) IP version: IPV4 or IPV6. Default is "IPV4".
    address      = null         # (Optional) The static IP address to reserve. Default is null.
    subnetwork   = null         # (Optional) Subnetwork for internal addresses. Default is null.
    description  = null         # (Optional) Description for the reserved IP address. Default is null.
    region       = null         # (Optional) Region for the IP reservation. Default is null.
  }
  is_hub = false   # (Optional) Is this a hub or spoke configuration? Default is false.
  spoke_def = "001"   # (Optional) Spoke ID Number, must be a 3 digit number. Default is "001".
  org = {   # (Required) Organization details.
    organization_name = "example-org"  # (Required) Name of the organization.
    organization_unit = "operations"   # (Required) Name of the organization unit.
    environment_type  = "production"   # (Required) Type of the environment.
    environment_name  = "main"         # (Required) Name of the environment.
  }
  extra_tags = {   # (Optional) Extra tags to add to the resources.
    Owner = "CloudOps"
  }
}
```

### Variables documentation in YAML format:

```yaml
reservation_number: 1   # (Optional) Number of reserved IP addresses. Default is 1.
ip_settings:   # (Optional) Map of settings for the IP address. Default is {}.
  address_type: "EXTERNAL"   # (Optional) Type of address: INTERNAL or EXTERNAL. Default is "EXTERNAL".
  ip_version: "IPV4"         # (Optional) IP version: IPV4 or IPV6. Default is "IPV4".
  address: null              # (Optional) The static IP address to reserve. Default is null.
  subnetwork: null           # (Optional) Subnetwork for internal addresses. Default is null.
  description: null          # (Optional) Description for the reserved IP address. Default is null.
  region: null               # (Optional) Region for the IP reservation. Default is null.
is_hub: false   # (Optional) Is this a hub or spoke configuration? Default is false.
spoke_def: "001"   # (Optional) Spoke ID Number, must be a 3 digit number. Default is "001".
org:   # (Required) Organization details.
  organization_name: "example-org"   # (Required) Name of the organization.
  organization_unit: "operations"    # (Required) Name of the organization unit.
  environment_type: "production"     # (Required) Type of the environment.
  environment_name: "main"           # (Required) Name of the environment.
extra_tags: {}   # (Optional) Extra tags to add to the resources. Default is {}.
```

## Quick Start

To get started quickly with this module:

1. Define your Terragrunt configuration in a `terragrunt.hcl` file.
2. Configure the required `org` variables to match your environment.
3. Run `terragrunt plan` to review the allocation plan.
4. Run `terragrunt apply` to allocate and reserve the static IP addresses.

## Examples

### Basic Usage

Create a single external IP address with default settings:

```hcl
inputs = {
  org = {
    organization_name = "example-org"
    organization_unit = "it"
    environment_type  = "staging"
    environment_name  = "app"
  }
}
```

### Multiple Reservations

Reserve 5 IP addresses:

```hcl
inputs = {
  reservation_number = 5
  org = {
    organization_name = "example-org"
    organization_unit = "it"
    environment_type  = "prod"
    environment_name  = "web"
  }
}
```

### Internal IP Reservation

Reserve internal IP addresses within a subnetwork:

```hcl
inputs = {
  reservation_number = 2
  ip_settings = {
    address_type = "INTERNAL"
    subnetwork   = "projects/my-project/regions/us-central1/subnetworks/my-subnet"
    region       = "us-central1"
  }
  org = {
    organization_name = "example-org"
    organization_unit = "it"
    environment_type  = "production"
    environment_name  = "internal"
  }
}
```

### IPv6 Reservation

Reserve IPv6 addresses:

```hcl
inputs = {
  ip_settings = {
    ip_version = "IPV6"
    address_type = "EXTERNAL"
  }
  org = {
    organization_name = "example-org"
    organization_unit = "it"
    environment_type  = "production"
    environment_name  = "ipv6"
  }
}
```

## Makefile Targets

```
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  init/aws                            Initialize the project for a specific cloud provider: AWS
  init/azurerm                        Initialize the project for a specific cloud provider: Azure RM
  init/gcp                            Initialize the project for a specific cloud provider: GCP
  lint                                Lint terraform/opentofu code
  tag                                 Tag the current version
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7 |
| google | ~> 7.0 |
| google-beta | ~> 7.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 7.0 |
| google-beta | ~> 7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| tags | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.ip_reservation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_org"></a> [org](#input_org) | Organization details | `object({ organization_name = string, organization_unit = string, environment_type = string, environment_name = string })` | n/a | yes |
| <a name="input_reservation_number"></a> [reservation_number](#input_reservation_number) | (optional) Number of reserved IP addresses, defaults to 1 | `number` | `1` | no |
| <a name="input_ip_settings"></a> [ip_settings](#input_ip_settings) | (optional) Map of settings for the IP address | `object({ address_type = string, ip_version = string, address = string, subnetwork = string, description = string, region = string })` | `{}` | no |
| <a name="input_is_hub"></a> [is_hub](#input_is_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_spoke_def"></a> [spoke_def](#input_spoke_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |
| <a name="input_extra_tags"></a> [extra_tags](#input_extra_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip_ids"></a> [public_ip_ids](#output_public_ip_ids) | Map of reserved IP addresses (name => id) |
| <a name="output_public_ips"></a> [public_ips](#output_public_ips) | List of reserved IP addresses |
| <a name="output_reservation_number"></a> [reservation_number](#output_reservation_number) | Number of reserved IP addresses |
| <a name="output_region"></a> [region](#output_region) | Region where IPs were reserved |
| <a name="output_ip_version"></a> [ip_version](#output_ip_version) | IP version of reserved addresses |
| <a name="output_address_type"></a> [address_type](#output_address_type) | Type of addresses (INTERNAL/EXTERNAL) |

## Help

**Got a question?** We got answers.

File a GitHub [issue](https://github.com/cloudopsworks/terraform-module-gcp-ip-reservation/issues), send us an [email](https://cowk.io/email?utm_source=github&utm_medium=readme&utm_campaign=terraform-module-gcp-ip-reservation&utm_content=email) or join our [Slack Community](https://cowk.io/slack?utm_source=github&utm_medium=readme&utm_campaign=terraform-module-gcp-ip-reservation&utm_content=slack).

## DevOps Tools

## Slack Community

## Newsletter

## Office Hours

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudopsworks/terraform-module-gcp-ip-reservation/issues) to report any bugs or file feature requests.

### Developing

## Copyrights

Copyright © 2024-2026 [Cloud Ops Works LLC](https://cloudops.works)

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained by [Cloud Ops Works LLC](https://cowk.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=terraform-module-gcp-ip-reservation&utm_content=website).

### Contributors
