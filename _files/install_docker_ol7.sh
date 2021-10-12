#!/bin/bash

# Last update : October, 2021
# Author: cetin.ardal@oracle.com
# Description: Install Docker Engine and cli on an Oracle Linux 7 instance running on OCI.

# OL7 repos contains old Docker version (19.xx), so we retrieve the packages from CentOS yum repo.
# OL8 have dropped support for Docker Engine and moved to Podman.
# As Nomad's Podman driver gains maturity, we may consider switching to OL8 with Podman as the container engine.

# Get OS Release number
OS_RELEASE=$(rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release))
OS_RELEASE_MAJOR=$(echo $OS_RELEASE | cut -d. -f1)

#-------------------------
# Add CentOS extras repo
#-------------------------

# Download the GPG key and save locally
curl -s https://www.centos.org/keys/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR-aarch64 | sudo tee /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR-aarch64
curl -s https://www.centos.org/keys/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR | sudo tee /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR

# Create the repo file
cat << EOF | sudo tee /etc/yum.repos.d/centos-extras.repo
#additional packages that may be useful
[extras]
name=CentOS-$OS_RELEASE_MAJOR - Extras
mirrorlist=http://mirrorlist.centos.org/?release=$OS_RELEASE_MAJOR&arch=\$basearch&repo=extras
#baseurl=http://mirror.centos.org/centos/$OS_RELEASE_MAJOR/extras/\$basearch/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR
priority=1
EOF

#-------------------------
# Install Docker CE
#-------------------------
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo systemctl enable docker
sudo usermod -aG docker opc