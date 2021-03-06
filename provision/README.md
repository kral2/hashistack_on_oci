# Provision HashiStack on OCI

## Table of Contents

1. [About](#about)
2. [Requirements](#requirements)
3. [Providers](#Providers)
4. [Inputs](#inputs)
5. [Outputs](#outputs)

## About

This Terraform template provision the infrastructure below:

![diagram](https://github.com/kral2/hashistack_on_oci/blob/main/_files/images/deployed_infrastructure.png?raw=true&sanitize=true)

- the bastion host use a `VM.Standard.E2.1.Micro` shape, which is part of the [Oracle Cloud Always Free tier](https://www.oracle.com/cloud/free/)
- the Nomad cluster nodes use [Oracle Ampere A1 Compute](https://developer.oracle.com/arm/) using `VM.Standard.A1.Flex` shape, configured with 1 core and 6GB of RAM each.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >=4.40.0 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance_bastion"></a> [instance\_bastion](#module\_instance\_bastion) | kral2/compute-instance/oci | 2.3.0-RC1 |
| <a name="module_instance_hashistack"></a> [instance\_hashistack](#module\_instance\_hashistack) | kral2/compute-instance/oci | 2.3.0-RC1 |
| <a name="module_vcn_hashistack"></a> [vcn\_hashistack](#module\_vcn\_hashistack) | oracle-terraform-modules/vcn/oci | 3.0.0 |
## Resources

| Name | Type |
|------|------|
| [oci_core_security_list.consul_servers](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_security_list) | resource |
| [oci_core_security_list.nomad_servers](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_security_list) | resource |
| [oci_core_subnet.vcn_hashistack_private](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet) | resource |
| [oci_core_subnet.vcn_hashistack_public](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_storage_sizes_in_gbs"></a> [block\_storage\_sizes\_in\_gbs](#input\_block\_storage\_sizes\_in\_gbs) | Sizes of volumes to create and attach to each instance. | `list(string)` | `[]` | no |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | compartment ocid where to create all resources | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | predefined and scoped to a namespace to tag the resources created using defined tags. | `map(string)` | `null` | no |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | n/a | `string` | `null` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | simple key-value pairs to tag the resources created using freeform tags. | `map(string)` | `null` | no |
| <a name="input_instance_ad_number"></a> [instance\_ad\_number](#input\_instance\_ad\_number) | The availability domain number of the instance. If none is provided, it will start with AD-1 and continue in round-robin. | `number` | `1` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of identical instances to launch from a single module. | `number` | `1` | no |
| <a name="input_instance_display_name"></a> [instance\_display\_name](#input\_instance\_display\_name) | (Updatable) A user-friendly name for the instance. Does not have to be unique, and it's changeable. | `string` | `"instance-module"` | no |
| <a name="input_instance_flex_memory_in_gbs"></a> [instance\_flex\_memory\_in\_gbs](#input\_instance\_flex\_memory\_in\_gbs) | (Updatable) The total amount of memory available to the instance, in gigabytes. | `number` | `6` | no |
| <a name="input_instance_flex_ocpus"></a> [instance\_flex\_ocpus](#input\_instance\_flex\_ocpus) | (Updatable) The total number of OCPUs available to the instance. | `number` | `1` | no |
| <a name="input_instance_state"></a> [instance\_state](#input\_instance\_state) | (Updatable) The target state for the instance. Could be set to RUNNING or STOPPED. | `string` | `"RUNNING"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | n/a | `string` | `null` | no |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | n/a | `string` | `null` | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | Whether to create a Public IP to attach to primary vnic and which lifetime. Valid values are NONE, RESERVED or EPHEMERAL. | `string` | `"RESERVED"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `null` | no |
| <a name="input_shape"></a> [shape](#input\_shape) | The shape of an instance. | `string` | `"VM.Standard.A1.Flex"` | no |
| <a name="input_source_ocid"></a> [source\_ocid](#input\_source\_ocid) | The OCID of an image or a boot volume to use, depending on the value of source\_type. | `string` | n/a | yes |
| <a name="input_source_type"></a> [source\_type](#input\_source\_type) | The source type for the instance. | `string` | `"image"` | no |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | Public SSH keys to be included in the ~/.ssh/authorized\_keys file for the default user on the instance. To provide multiple keys, see docs/instance\_ssh\_keys.adoc. | `string` | `null` | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | n/a | `string` | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Provide your own base64-encoded data to be used by Cloud-Init to run custom scripts or provide custom Cloud-Init configuration. | `string` | `null` | no |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | n/a | `string` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_bastion"></a> [instance\_bastion](#output\_instance\_bastion) | ocid of created instances. |
| <a name="output_instance_hashistack"></a> [instance\_hashistack](#output\_instance\_hashistack) | ocid of created instances. |

<!-- END_TF_DOCS -->