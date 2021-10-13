/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: define network topology
*/

module "vcn_hashistack" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.0.0"

  # general oci parameters
  compartment_id = var.compartment_id

  # vcn parameters
  create_drg               = false             # boolean: true or false
  create_internet_gateway  = true              # boolean: true or false
  lockdown_default_seclist = false             # boolean: true or false
  create_nat_gateway       = true              # boolean: true or false
  create_service_gateway   = true              # boolean: true or false
  vcn_cidrs                = ["172.16.0.0/16"] # List of IPv4 CIDRs
  vcn_dns_label            = "hashistack"
  vcn_name                 = "hashistack"
}

resource "oci_core_subnet" "vcn_hashistack_public" {
  #Required
  cidr_block     = "172.16.0.0/24"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_hashistack.vcn_id

  #Optional
  display_name               = "public"
  dns_label                  = "public"
  prohibit_public_ip_on_vnic = false
  route_table_id             = module.vcn_hashistack.ig_route_id
  security_list_ids          = [module.vcn_hashistack.vcn_all_attributes.default_security_list_id]
}

resource "oci_core_subnet" "vcn_hashistack_private" {
  #Required
  cidr_block     = "172.16.1.0/24"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_hashistack.vcn_id

  #Optional
  display_name               = "private"
  dns_label                  = "private"
  prohibit_public_ip_on_vnic = true
  route_table_id             = module.vcn_hashistack.nat_route_id
  security_list_ids          = [module.vcn_hashistack.vcn_all_attributes.default_security_list_id, oci_core_security_list.nomad_servers.id, oci_core_security_list.consul_servers.id]
}