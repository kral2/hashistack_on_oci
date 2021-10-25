/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: provision an instance for iac development in its own network context
*/

locals {
  formatted_timestamp = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
}

module "instance_hashistack" {
  source  = "kral2/compute-instance/oci"
  version = "2.3.0-RC1"

  # general oci parameters
  compartment_ocid = var.compartment_id
  freeform_tags    = var.freeform_tags
  # compute instance parameters
  ad_number                   = var.instance_ad_number
  instance_count              = var.instance_count
  instance_display_name       = var.instance_display_name
  instance_state              = var.instance_state
  shape                       = var.shape
  source_ocid                 = var.source_ocid
  source_type                 = var.source_type
  instance_flex_memory_in_gbs = var.instance_flex_memory_in_gbs # only used if shape is Flex type
  instance_flex_ocpus         = var.instance_flex_ocpus         # only used if shape is Flex type
  # operating system parameters
  ssh_public_keys = var.ssh_public_keys
  # networking parameters
  subnet_ocids = [oci_core_subnet.vcn_hashistack_private.id] # var.subnet_ocids
  private_ips  = ["172.16.1.11", "172.16.1.12", "172.16.1.13"]
  # storage parameters
  block_storage_sizes_in_gbs = [] # no block volume will be created
}

module "instance_bastion" {
  source  = "kral2/compute-instance/oci"
  version = "2.3.0-RC1"

  # general oci parameters
  compartment_ocid = var.compartment_id
  freeform_tags    = var.freeform_tags
  # compute instance parameters
  ad_number                   = var.instance_ad_number
  instance_count              = 1
  instance_display_name       = "stack_bastion"
  instance_state              = var.instance_state
  shape                       = "VM.Standard.E2.1.Micro"
  source_ocid                 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaw6q7whpy3hkxhimt4hxwcdmc6wnh7wkcz55yervlx5x55yg6xklq" # Oracle-Autonomous-Linux-7.9-2021.09-1
  source_type                 = var.source_type
  instance_flex_memory_in_gbs = var.instance_flex_memory_in_gbs # only used if shape is Flex type
  instance_flex_ocpus         = var.instance_flex_ocpus         # only used if shape is Flex type
  # operating system parameters
  ssh_public_keys = var.ssh_public_keys
  # networking parameters
  public_ip    = var.public_ip
  subnet_ocids = [oci_core_subnet.vcn_hashistack_public.id] # var.subnet_ocids
  # storage parameters
  block_storage_sizes_in_gbs = [] # no block volume will be created
}