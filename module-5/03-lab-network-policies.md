# 🧪 Lab 5.3 – Network Policies

## 🎯 Objectives
- Create and test **NetworkPolicies** to restrict pod communication
- Use labels and namespaces to simulate segmentation

---

## 🔧 Prerequisites
- A running **Kind cluster** with a **CNI that supports Network Policies** (e.g., Calico or Cilium)

## 🛠️ Step 1 – Create Namespace & Pods
```bash
kubectl create ns lab5-netpol
kubectl config set-context --current --namespace=lab5-netpol
```

### Create Pods with Labels
```bash
kubectl run frontend --image=nginx --labels=app=frontend --expose --port=80
kubectl run backend --image=nginx --labels=app=backend --expose --port=80
```

### Test Initial Connectivity
```bash
kubectl run tester --image=busybox:1.28 -it --rm -- wget -O- backend
```
✅ Should succeed before applying any policies.

---

## 🚫 Step 2 – Apply Default Deny Policy
```yaml
# default-deny.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
spec:
  podSelector: {}
  policyTypes:
    - Ingress
```
```bash
kubectl apply -f default-deny.yaml
```

### Re-test from `tester` pod
```bash
kubectl run tester --image=busybox:1.28 -it --rm -- wget -O- backend
```
❌ Should now fail

---

## ✅ Step 3 – Allow Specific Ingress (From Frontend Only)
```yaml
# allow-frontend.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend
spec:
  podSelector:
    matchLabels:
      app: backend
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: frontend
```
```bash
kubectl apply -f allow-frontend.yaml
```

---

## 🔍 Test with frontend pod
```bash
kubectl exec -it frontend -- wget -O- backend
```
✅ Should succeed

### Test again with tester
```bash
kubectl run tester --image=busybox:1.28 -it --rm -- wget -O- backend
```
❌ Should still fail

---

## 🧼 Cleanup
```bash
kubectl delete ns lab5-netpol
```

✅ End of Lab 5.3 – You’ve implemented and tested Network Policies
