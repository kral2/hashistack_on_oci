# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

## [0.1.0] - 2021-10-11

Initial release. Deploys the infrastructure required to run an HashiStack demo on OCI.

BUILD : Packer, Ansible, Bash

- a Custom Image ready to deploy Nomad nodes on Linux/aarch

PROVISION : Terraform Registry, Terraform Cloud, OCI

- Networking structure with a bastion host

RUN : Nomad

- 3-nodes nomad cluster
