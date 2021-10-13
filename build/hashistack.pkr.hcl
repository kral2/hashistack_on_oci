/*
Last update : February, 2021
Author: cetin.ardal@oracle.com
Description: Define Packer template for oicagent custom image
*/

source "oracle-oci" "custom_image" {
  # provider connection information
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  key_file         = var.key_file
  compartment_ocid = var.compartment_ocid

  # builder information
  region              = var.region
  availability_domain = var.availability_domain
  shape               = var.shape
  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }
  instance_name              = "packer_build_${var.instance_name}_v${var.instance_user_freeform_tags["version"]}"
  instance_tags              = local.merged_instance_freeform_tags
  instance_defined_tags_json = jsonencode(var.instance_user_defined_tags)
  subnet_ocid                = var.subnet_ocid
  ssh_username               = var.ssh_username

  # Image information

  # User either base_image_ocid or base_image_filter:
  # - base_image_ocid is useful to start from a specific base image
  # - base_image_filter is useful to start with the latest version of a platform image
  #
  # If base_image_ocid is uncommented, base_image_filter is ignored.

  # base_image_ocid = var.base_image_ocid
  base_image_filter {
    operating_system         = var.base_image_filter["operating_system"]
    operating_system_version = var.base_image_filter["operating_system_version"]
  }
  image_name        = "${var.image_name}_v${var.image_user_freeform_tags["version"]}"
  tags              = local.merged_image_freeform_tags
  defined_tags_json = jsonencode(var.image_user_defined_tags)
}

build {
  name    = "consul_nomad"
  sources = ["source.oracle-oci.custom_image"]

  provisioner "shell" {
    scripts = ["../_files/install_docker_ol7.sh"]
  }

  provisioner "shell" {
    scripts = ["../_files/download_hashistack.sh"]
  }

  provisioner "ansible" {
    playbook_file = "ansible/main.yaml"
  }

  post-processor "manifest" {
    output      = "packer-manifest.json"
    custom_data = local.merged_image_freeform_tags
  }

  post-processor "shell-local" {
    scripts = ["inject_image_ocid_to_terraform.sh"]
  }
}
