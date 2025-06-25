#!/bin/bash

set -euo pipefail

echo "🔧 Installing Kubernetes tools on Ubuntu 24.04..."

# Update and install base packages
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

# --- Docker Installation from Official Repository ---
echo "🐳 Setting up Docker apt repository..."

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

echo "📦 Installing Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker

# Add current user to docker group
echo "👤 Adding user '$USER' to docker group..."
sudo usermod -aG docker "$USER"

# --- kubectl Installation ---
echo "🧰 Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

# --- Kind Installation ---
echo "📦 Installing Kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x kind
sudo mv kind /usr/local/bin/kind

# --- Helm Installation ---
echo "🚀 Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "✅ All tools installed!"
echo "🔁 Please log out and log back in (or run 'newgrp docker') to use Docker without sudo."