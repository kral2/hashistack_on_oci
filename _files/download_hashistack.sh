#!/bin/sh

# Getting latest HashiStack components

# This is a small helper script that calls hashistack-installer to Install Nomad, Consul and Vault.
# At the moment, only Nomad is used. But that's so simple and low cost to retrieve the other runtimes, so why not :-)
# If/when https://iac.sh evovles to support the installation of HashiCorp products other than Terraform and Packer,
# we may switch to it instead of my current installer.

curl -LO https://raw.github.com/kral2/hashistack-installer/main/hashistack-install.sh
chmod +x hashistack-install.sh
./hashistack-install.sh consul vault nomad