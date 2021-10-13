/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: define network security
*/

resource "oci_core_security_list" "nomad_servers" {
  #Required
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_hashistack.vcn_id
  display_name   = "SL_nomad"

  # server rules

  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "172.16.1.0/24"
    #Optional
    description = "Nomad RPC"
    tcp_options {

      #Optional
      max = "4647"
      min = "4647"
    }
  }
  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "172.16.1.0/24"
    #Optional
    description = "Nomad Gossip/TCP"
    tcp_options {

      #Optional
      max = "4648"
      min = "4648"
    }
  }
  ingress_security_rules {
    #Required
    protocol = "17"
    source   = "172.16.1.0/24"
    #Optional
    description = "Nomad Gossip/UDP"
    udp_options {

      #Optional
      max = "4648"
      min = "4648"
    }
  }

  # client rules

  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "0.0.0.0/0"
    #Optional
    description = "Nomad HTTP API"
    tcp_options {

      #Optional
      max = "4646"
      min = "4646"
    }
  }

  ingress_security_rules {
    #Required
    protocol = "1"
    source   = "172.16.0.0/16"
    #Optional
    description = "ping party on the vcn"
  }
}

resource "oci_core_security_list" "consul_servers" {
  #Required
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_hashistack.vcn_id
  display_name   = "SL_consul"

  # server rules

  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "172.16.1.0/24"
    #Optional
    description = "Consul RPC"
    tcp_options {

      #Optional
      max = "8300"
      min = "8300"
    }
  }

  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "172.16.1.0/24"
    #Optional
    description = "Consul Gossip/TCP (Serf LAN)"
    tcp_options {

      #Optional
      max = "8301"
      min = "8301"
    }
  }
  ingress_security_rules {
    #Required
    protocol = "17"
    source   = "172.16.1.0/24"
    #Optional
    description = "Consul Gossip/UDP (Serf LAN)"
    udp_options {

      #Optional
      max = "8301"
      min = "8301"
    }
  }

  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "172.16.1.0/24"
    #Optional
    description = "Consul Gossip/TCP (Serf WAN)"
    tcp_options {

      #Optional
      max = "8302"
      min = "8302"
    }
  }
  ingress_security_rules {
    #Required
    protocol = "17"
    source   = "172.16.1.0/24"
    #Optional
    description = "Consul Gossip/UDP (Serf WAN)"
    udp_options {

      #Optional
      max = "8302"
      min = "8302"
    }
  }

  # client rules

  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "0.0.0.0/0"
    #Optional
    description = "Consul HTTP API"
    tcp_options {

      #Optional
      max = "8500"
      min = "8500"
    }
  }

  ingress_security_rules {
    #Required
    protocol = "6"
    source   = "0.0.0.0/0"
    #Optional
    description = "Consul DNS Interface"
    tcp_options {

      #Optional
      max = "8600"
      min = "8600"
    }
  }
}
