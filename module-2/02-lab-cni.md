# 🧪 CNI Lab – Kubernetes Networking with Cilium

This lab will help you understand how Kubernetes networking works by disabling the default CNI, installing Cilium, and observing pod communication.

---

## 🌟 Objectives

* Create a Kind cluster **without a default CNI**
* Install the **Cilium CNI plugin** manually
* Deploy test pods across namespaces
* Test communication before and after applying **Network Policies**

---

## 🚀 Step 1: Create a Kind Cluster Without Default CNI

Create a `kind-config.yaml` file:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: cni-lab
networking:
  disableDefaultCNI: true
nodes:
  - role: control-plane
    image: kindest/node:v1.32.0
```

Then create the cluster:

```bash
kind create cluster --config kind-config.yaml
```

> ⚠️ Pods won't start until a CNI is installed.

---

## 🌐 Step 2: Install Cilium CLI & CNI

### 🖥️ macOS

```bash
brew install cilium-cli
cilium install --version 1.14.6 --cluster-name cni-lab --wait
```

### 🐧 Linux

```bash
curl -LO https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz
sudo tar -xvzf cilium-linux-amd64.tar.gz -C /usr/local/bin
cilium install --version 1.14.6 --cluster-name cni-lab --wait
```

### 🪟 Windows (via PowerShell)

1. Download the CLI from:
   [https://github.com/cilium/cilium-cli/releases](https://github.com/cilium/cilium-cli/releases)
2. Extract and add the path to your system `PATH`
3. Run:

```powershell
cilium install --version 1.14.6 --cluster-name cni-lab --wait
```

### ✅ Validate the installation

```bash
cilium status
kubectl get pods -n kube-system -l k8s-app=cilium
```

---

## 📄 Step 3: Deploy Test Pods in Different Namespaces

```bash
kubectl create ns ns-a
kubectl create ns ns-b

kubectl run ping-a --image=busybox -n ns-a --restart=Never -- sleep 3600
kubectl run ping-b --image=busybox -n ns-b --restart=Never -- sleep 3600

kubectl get pods -A -o wide
```

Wait until both pods are Running. Then test communication:

```bash
kubectl exec -n ns-a ping-a -- ping ping-b.ns-b.svc.cluster.local
```

> 🚀 Pods should be able to ping each other initially (before any policy).

---

## 🔒 Step 4: Apply a Network Policy to Restrict Traffic

Create a file `deny-ns-b.yaml`:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
  namespace: ns-b
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

Apply the policy:

```bash
kubectl apply -f deny-ns-b.yaml
```

Try the ping again:

```bash
kubectl exec -n ns-a ping-a -- ping ping-b.ns-b.svc.cluster.local
```

> ❌ Communication should now be **blocked**.

---

## 🧹 Step 5: Clean Up

```bash
kind delete cluster --name cni-lab
```

---

## ✅ Checklist

* [ ] Created a Kind cluster with CNI disabled
* [ ] Installed Cilium CNI plugin successfully
* [ ] Deployed test pods and validated initial communication
* [ ] Applied a NetworkPolicy and confirmed restricted access
* [ ] Deleted the cluster

---

## 💬 What's Next?

You're now familiar with how CNI plugins work and how Network Policies enforce segmentation. In a future lab, you'll explore CRI and CSI in more depth.
