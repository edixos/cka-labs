# 🧪 Module 1 Lab – Kubernetes Tooling Setup & Environment Check

This lab will help you install the required CLI tools, create a local Kubernetes cluster using `kind`, and verify that everything is set up properly.

---

## 🌟 Objectives

* Install and verify the following tools:

  * `kubectl`
  * `kind`
  * `helm`
* Create a local Kubernetes cluster with **Kubernetes v1.32**
* Use basic `kubectl` commands to explore the API

---

## ⚙️ Prerequisites

Ensure you have:

* Docker installed and running on your machine
* Internet access to download binaries

---

## 🛠️ Step 1: Install Required Tools

### ✅ kubectl (Kubernetes CLI)

```bash
curl -LO "https://dl.k8s.io/release/v1.32.0/bin/$(uname | tr '[:upper:]' '[:lower:]')/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
```

---

### ✅ kind (Kubernetes in Docker)

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-$(uname)-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
kind version
```

---

### ✅ helm (Kubernetes package manager)

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
```

---

## 🚀 Step 2: Create a Kind Cluster (Kubernetes v1.32)

Create a config file `kind-config.yaml`:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: cka-lab
nodes:
  - role: control-plane
    image: kindest/node:v1.32.0
```

Then create the cluster:

```bash
kind create cluster --config kind-config.yaml
```

> 📝 Note: If the `v1.32.0` image is not available, use the closest supported version (e.g. `v1.31.1`) and mention this during the training.

---

## 🔍 Step 3: Verify the Cluster

```bash
kubectl cluster-info
kubectl get nodes
kubectl version
```

---

## 📖 Step 4: Explore the Kubernetes API

```bash
kubectl api-resources
kubectl explain pod
kubectl explain deployment.spec.template
```

---

## 🔧 Step 5: Clean Up (Teardown)

To remove the local cluster and reset your environment:

```bash
kind delete cluster --name cka-lab
```

> ✅ Always clean up your environment after each lab to ensure you're starting fresh in the next one.

---

## ✅ Checklist

* [ ] All tools (`kubectl`, `kind`, `helm`) installed and working
* [ ] Kind cluster created with Kubernetes v1.32
* [ ] `kubectl` returns cluster info and node details
* [ ] Able to use `kubectl explain` and list API resources
* [ ] Cluster cleaned up with `kind delete cluster`

---

## 💬 What’s Next?

You’re ready to begin real cluster interactions! In the next module, we’ll start managing workloads, objects, and resources in your new Kubernetes cluster.
