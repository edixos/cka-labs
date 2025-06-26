#!/bin/bash
set -euo pipefail

CLUSTER_NAME="cni-lab"
K8S_VERSION="v1.32.0"
KIND_IMAGE="kindest/node:$K8S_VERSION"

echo "🔧 Configuring Docker to use systemd as cgroup driver..."

# Create or update Docker daemon.json
DOCKER_CONFIG='/etc/docker/daemon.json'
sudo mkdir -p /etc/docker
sudo bash -c "cat > $DOCKER_CONFIG" <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

echo "✅ Docker config updated."

echo "🔄 Restarting Docker..."
sudo systemctl daemon-reexec
sudo systemctl restart docker
sleep 5
echo "✅ Docker restarted."