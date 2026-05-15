#!/usr/bin/env bash

set -e

echo "================================================="
echo "INSTALLING DOCKER"
echo "================================================="

apt-get update

apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# =========================================================
# DOCKER GPG KEY
# =========================================================

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor \
    -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

# =========================================================
# DOCKER REPOSITORY
# =========================================================

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

# =========================================================
# INSTALL DOCKER
# =========================================================

apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# =========================================================
# ENABLE DOCKER
# =========================================================

systemctl enable docker
systemctl start docker

usermod -aG docker vagrant

echo "================================================="
echo "DOCKER INSTALLED"
echo "================================================="