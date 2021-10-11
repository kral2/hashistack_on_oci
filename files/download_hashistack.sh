#!/bin/sh

# getting latest HashiStack components (Consul, Vault, Nomad)
curl -LO https://raw.github.com/kral2/hashistack-installer/main/hashistack-install.sh
chmod +x hashistack-install.sh
./hashistack-install.sh consul vault nomad