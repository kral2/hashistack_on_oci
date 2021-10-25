# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

## [0.3.0] - unreleased

### Added

- Compute Instances state control can be RUNNING or STOPPED (Cluster nodes and Bastion)

### Changed

- use development compute-instance module from kral2/compute-instance/oci in place of oracle-terraform-modules/compute-instance/oci

### Fixed

- Packer: `image_compartment_ocid` variable input is now honored, instead of placing Image in the same compartment than the build instance

## [0.2.0] - 2021-10-13

### Added

- Consul Cluster : the compute instances that run the Nomad cluster now also run a 3-node Consul cluster.
- Terraform provisioning update: a new VCN Security List for Consul
- New playbook to restart Consul or Nomad services on running clusters

### Changed

- Nomad and Consul systemd service units are now in state enabled at the build stage.
- Use [go-sockaddr](https://github.com/hashicorp/go-sockaddr) template on consul_config/server.hcl to determine the node IP address at launch time and not hard coded in the Packer build image.
- hashistack-installer is now pinned to a tag version for more deterministic output

## [0.1.0] - 2021-10-11

Initial release. Deploys the infrastructure required to run an HashiStack demo on OCI.

BUILD : Packer, Ansible, Bash

- a Custom Image ready to deploy Nomad nodes on Linux/aarch

PROVISION : Terraform Registry, Terraform Cloud, OCI

- Networking structure with a bastion host

RUN : Nomad

- 3-nodes nomad cluster
