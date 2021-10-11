/*
Last update : February, 2021
Author: cetin.ardal@oracle.com
Description: Packer template variables file
*/

#####################################
# OCI Provider connection information
#####################################

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of your tenancy. Overrides value provided by the OCI config file if present."
  default     = null
}

variable "user_ocid" {
  type        = string
  description = "The OCID of the user calling the OCI API. Overrides value provided by the OCI config file if present."
  default     = null
}

variable "fingerprint" {
  type        = string
  description = "Fingerprint for the OCI API signing key. Overrides value provided by the OCI config file if present."
  default     = null
}

variable "key_file" {
  type        = string
  description = "Full path and filename of the OCI API signing key. Overrides value provided by the OCI config file if present."
  default     = null
}

###############
# Common Locals
###############

locals {
  default_freeform_tags = {
    # This list of freeform tags are added by default, on build resources and build artefacts
    Terraformed             = "No"
    Packer_Template_version = "v1.1"
  }
  merged_image_freeform_tags    = merge(local.default_freeform_tags, var.image_watermark_freeform_tags, var.image_user_freeform_tags, var.base_image_filter)
  merged_instance_freeform_tags = merge(local.default_freeform_tags, var.instance_watermark_freeform_tags, var.instance_user_freeform_tags)
}

#####################
# Builder information
#####################

variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment that the instance will run in."
  default     = null
}

variable "region" {
  type        = string
  description = "An Oracle Cloud Infrastructure region. Overrides value provided by the OCI config file if present."
  default     = null
}

variable "availability_domain" {
  type        = string
  description = "The name of the Availability Domain within which a new instance is launched and provisioned."
  default     = null
}

variable "shape" {
  type        = string
  description = "The template that determines the number of CPUs, amount of memory, and other resources allocated to a newly created instance."
  default     = "VM.Standard.E4.Flex"
}

variable "instance_name" {
  type        = string
  description = "The name to assign to the instance used for the image creation process. If not set a name of the form instanceYYYYMMDDhhmmss will be used."
  default     = null
}

variable "instance_user_freeform_tags" {
  type        = map(string)
  description = "Add one or more freeform tags to the instance used for the image creation process."
  default = {
    version = "0.3.0"
  }
}

variable "instance_watermark_freeform_tags" {
  type        = map(string)
  description = "List of freeform tags are added by default, only on build resources."
  default = {
    HashiPacked = "Yes"
  }
}

variable "instance_user_defined_tags" {
  type        = map(string)
  description = "Add one or more defined tags for a given namespace to the instance used for the image creation process."
  default     = {}
}

variable "subnet_ocid" {
  type        = string
  description = "The name of the subnet within which a new instance is launched and provisioned."
  default     = null
}

variable "ssh_username" {
  type        = string
  description = "ssh username to b used by the builder to connect to the build instance."
  default     = "opc"
}

###################
# Image information
###################

variable "base_image_ocid" {
  type        = string
  description = "The OCID of the base image to use. This is the unique identifier of the image that will be used to launch a new instance and provision it."
  default     = null
}

variable "base_image_filter" {
  type        = map(string)
  description = "As an alternative to providing base_image_ocid, the user can supply search criteria, and Packer will use the the most recent image that meets all search criteria."
  default = {
    operating_system         = "Oracle Linux"
    operating_system_version = "7.9"
  }
}

variable "image_name" {
  type        = string
  description = "The name to assign to the resulting custom image."
  default     = "oicagent"
}

variable "image_compartment_ocid" {
  type        = string
  description = "The OCID of the target compartment for the resulting image. Defaults to compartment_ocid."
  default     = null
}

variable "image_user_freeform_tags" {
  type        = map(string)
  description = "Add one or more freeform tags to the resulting custom image."
  default = {
    version = "0.1.0"
  }
}

variable "image_watermark_freeform_tags" {
  type        = map(string)
  description = "List of freeform tags are added by default, only on build artefacts."
  default = {
    HashiPacked = "Yes"
  }
}

variable "image_user_defined_tags" {
  type        = map(string)
  description = "Add one or more defined tags for a given namespace to the resulting custom image."
  default     = {}
}
