#!/bin/bash

set -euo pipefail

echo "🔧 Installing Kubernetes tools on Ubuntu 24.04..."

# Update and install prerequisites
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gpg lsb-release software-properties-common

# --- Docker Installation ---
echo "🐳 Installing Docker..."
sudo apt-get install -y docker.io
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
echo "🧼 You may need to log out and back in to use Docker without sudo."