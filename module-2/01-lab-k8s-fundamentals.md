# 🧪 Module 2 Lab – Kubernetes Fundamentals: Cluster & API Exploration

This lab helps you discover how to interact with a Kubernetes cluster using `kubectl`, identify cluster components, and inspect available API resources.

---

## 🌟 Objectives

* Create a local Kubernetes cluster with `kind`
* Explore the cluster with `kubectl`
* Identify control plane and worker components
* Use the Kubernetes API to discover resource definitions and usage

---

## 🚀 Step 0: Create a Kind Cluster

Before starting, make sure Docker is running and the following configuration is used to create your Kind cluster:

### `kind-config.yaml`

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

> 📝 This configuration uses `containerd` as the runtime and a basic default CNI setup.

---

## 🔍 Step 1: Verify Cluster Access

```bash
kubectl cluster-info
kubectl get nodes -o wide
kubectl version
```

> Make sure you have a running cluster and `kubectl` is configured correctly.

---

## 🔍 Step 2: Discover API Resources

```bash
kubectl api-resources
kubectl get --raw /apis | jq
kubectl explain pod
kubectl explain deployment.spec.template.spec.containers
```

> Explore the structure of Kubernetes objects and API groups.

---

## 🔧 Step 3: Clean Up (Optional)

To remove the local cluster and reset your environment:

```bash
kind delete cluster --name cka-lab
```

---

## ✅ Checklist

* [ ] Created Kind cluster with Kubernetes v1.32
* [ ] Verified cluster access with `kubectl`
* [ ] Explored API resources with `kubectl explain` and raw queries
* [ ] Cluster cleaned up after completion

---

## 💬 What’s Next?

You're now familiar with your Kubernetes environment and the API. In the next module, you'll begin deploying workloads and managing cluster objects.

> Note: CNI, CRI, and CSI interfaces will be covered in a **dedicated lab**.
