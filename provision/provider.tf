/*
Last update : November, 2020
Author: cetin.ardal@oracle.com
Description: Define Terraform cli and provider versions, Configure providers
*/

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    oci = {
      version = ">=4.40.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  private_key      = var.private_key
  region           = var.region
}
