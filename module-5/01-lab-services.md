# 🧪 Lab 5.1 – Service Types & CoreDNS (Networking Fundamentals)

## 🎯 Objectives
- Create and test different **Service types**: ClusterIP, NodePort, LoadBalancer
- Validate **DNS resolution** using CoreDNS and `nslookup`

---

## 🔧 Prerequisites
- A running **Kind cluster** with default CNI and CoreDNS
- Namespace `lab5-services` created:
  ```bash
  kubectl create ns lab5-services
  kubectl config set-context --current --namespace=lab5-services
  ```

---

## 🛠️ Step 1 – Create a Basic Deployment

```bash
kubectl create deployment webapp --image=nginx --port=80
```

---

## 🔁 Step 2 – Expose with Different Service Types

### ClusterIP (default)
```bash
kubectl expose deployment webapp --port=80 --target-port=80 --type=ClusterIP
kubectl get svc webapp
```

### NodePort
```bash
kubectl expose deployment webapp-nodeport --image=nginx --port=80
kubectl patch svc webapp-nodeport -p '{"spec": {"type": "NodePort"}}'
```

### LoadBalancer (simulated in Kind)
```bash
kubectl expose deployment webapp-lb --image=nginx --port=80 --type=LoadBalancer
```
💡 Kind simulates LoadBalancer via extra port mappings or MetalLB (optional)

---

## 🔎 Step 3 – Test DNS Resolution with CoreDNS

### Launch a debug pod
```bash
kubectl run -it dnsutils --image=busybox:1.28 --restart=Never --rm -- nslookup webapp
```

Or use:
```bash
kubectl exec -it <any-pod> -- nslookup webapp
```

---

## 🧼 Cleanup
```bash
kubectl delete ns lab5-services
```

✅ End of Lab 5.1 – You’ve explored service types and validated cluster DNS
