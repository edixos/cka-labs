# 📘 Kubeadm Kubernetes Cheatsheet for Linux

A useful script and command reference for managing Kubernetes clusters with **kubeadm** on Linux.

---

## 🚀 Installation Scripts

### Set up Kubernetes APT Repo (v1.32)

```bash
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor --no-tty | \
  sudo tee /etc/apt/keyrings/kubernetes-apt-keyring.gpg > /dev/null

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list
```

### Install Specific Kubernetes Version (v1.32.6)

```bash
sudo apt-get update
sudo apt-get install -y kubelet=1.32.6-1.1 kubeadm=1.32.6-1.1 kubectl=1.32.6-1.1 --allow-downgrades
sudo apt-mark hold kubelet kubeadm kubectl
```

### Enable containerd with `SystemdCgroup = true`

```bash
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
```

---

## ⚙️ Core Cluster Commands

### Initialize Cluster (Master)

```bash
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --kubernetes-version=1.32.6
```

### Setup kubeconfig (for current user)

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Join Worker Node

```bash
# Run the command shown by kubeadm init output
sudo kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>
```

### Reset Cluster

```bash
sudo kubeadm reset -f
sudo rm -rf $HOME/.kube
sudo systemctl restart containerd
```

### Upgrade Cluster to v1.33.2

#### Step 1 – Unhold kube components

```bash
sudo apt-mark unhold kubelet kubeadm kubectl
```

#### Step 2 – Update APT Repo to v1.33

```bash
sudo sed -i 's/v1.32/v1.33/g' /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor --no-tty | \
  sudo tee /etc/apt/keyrings/kubernetes-apt-keyring.gpg > /dev/null
sudo apt-get update
```

#### Step 3 – Upgrade kubeadm

```bash
sudo apt-get install -y kubeadm=1.33.2-1.1
```

#### Step 4 – Plan & Apply Upgrade

```bash
sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.33.2
```

#### Step 5 – Upgrade kubelet and kubectl

```bash
sudo apt-get install -y kubelet=1.33.2-1.1 kubectl=1.33.2-1.1
sudo systemctl restart kubelet
sudo apt-mark hold kubelet kubeadm kubectl
```

---

## 🧪 Debugging Tips

* Check component status:

  ```bash
  kubectl get pods -n kube-system
  ```
* Check logs:

  ```bash
  journalctl -u kubelet -f
  ```
* Check kubeadm logs:

  ```bash
  sudo kubeadm reset -f && sudo kubeadm init
  ```

---

## Backup and Recovery etcd

### Backup etcd Data

```bash
sudo ETCDCTL_API=3 etcdctl snapshot save /var/lib/etcd/snapshot.db \
  --endpoints=https://<MASTER_IP>:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key
```

### Restore etcd Data

```bash
sudo ETCDCTL_API=3  etcdctl snapshot restore /var/lib/etcd/snapshot.db \
  --endpoints=https://127.0.0.1:2379 \
  --data-dir=/var/lib/etcd-backup \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key
```

✅ Use this cheatsheet as your go-to reference for cluster setup, recovery, and upgrades!
