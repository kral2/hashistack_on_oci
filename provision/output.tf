/*
Last update : February, 2021
Author: cetin.ardal@oracle.com
Description: current config outputs will be printed after plan and apply.
*/

output "instance_hashistack" {
  description = "ocid of created instances."
  value       = module.instance_hashistack.instances_summary
}

output "instance_bastion" {
  description = "ocid of created instances."
  value       = module.instance_bastion.instances_summary
}
