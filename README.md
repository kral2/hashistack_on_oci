# HashiStack on OCI

## Build, Provision and Run a 3-nodes Nomad cluster on OCI "Always-Free" Tier

[![release](https://img.shields.io/github/v/release/kral2/hashistack_on_oci?colorB=2067b8)](https://github.com/kral2/hashistack_on_oci)
[![hcl](https://img.shields.io/badge/language-hcl-89e051.svg?style=flat-square)](https://github.com/kral2/hashistack_on_oci)
[![bash](https://img.shields.io/badge/language-bash-89e051.svg?style=flat-square)](https://github.com/kral2/hashistack_on_oci)
[![bash](https://img.shields.io/badge/language-ansible-89e051.svg?style=flat-square)](https://github.com/kral2/hashistack_on_oci)
[![license](https://img.shields.io/github/license/kral2/hashistack_on_oci?colorB=2067b8)](https://github.com/kral2/hashistack_on_oci)

## Table of Contents

1. [About](#about)
2. [Requirements](#requirements)
3. [Providers](#Providers)
4. [Inputs](#inputs)
5. [Outputs](#outputs)

## About

This project build an "HashiStack" demo on [OCI](https://docs.oracle.com/en-us/iaas/Content/home.htm). It is a 3-step workflow:

1. **BUILD:** using Packer, Ansible and Bash scripts. The output is a Custom Image, ready to deploy Consul+Nomad nodes on Linux/arm64 using [Ampere Altra CPU](https://amperecomputing.com/)
2. **PROVISION:** using Terraform Registry, Terraform Cloud with OCI. The output is an OCI Networking structure and security rules, together with 3 Computes Instances and a bastion host
3. **RUN:** with [Consul](https://www.consul.io/) and [Nomad](https://www.nomadproject.io/) on a 3-nodes cluster, with some example Nomad jobs and Consul content to come

![diagram](https://github.com/kral2/hashistack_on_oci/blob/main/_files/images/3-Steps_workflow.png?raw=true&sanitize=true)

Details about the provisioned infrastructure can be found in the ["Provision" folder](https://github.com/kral2/hashistack_on_oci/tree/main/provision) of this repo.

The whole architecure deployed by this project can be contained in the [Oracle Cloud Always Free tier](https://www.oracle.com/cloud/free/) allocation, which comes with Compute, Storage, the cloud networking stuff and a hefty 10TB Outbound Data Transfer per month. So it should not cost you a single penny to try :-D
