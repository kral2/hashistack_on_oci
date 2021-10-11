/*
Last update : November, 2020
Author: cetin.ardal@oracle.com
Description: Define Terraform backend
*/

terraform {
  backend "remote" {
    organization = "kral2"

    workspaces {
      name = "hashistack"
    }
  }
}