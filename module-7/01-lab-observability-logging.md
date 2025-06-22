
# 04🧪 Lab 7 – Observability & Logging

## 🎯 Objectives
- Access container logs using `kubectl logs`
- Observe pod behavior via **liveness** and **readiness probes**
- Monitor cluster and pod events via `kubectl get events`
- Use `kubectl top` to check resource usage
- Explore how **audit logs** are configured

---

## 🔧 Prerequisites
- A running **Kind cluster** with **metrics-server** installed
- Namespace `lab7-observability` created:
  ```bash
  kubectl create ns lab7-observability
  kubectl config set-context --current --namespace=lab7-observability
  ```

---

## 📄 Step 1 – Access Logs
```bash
kubectl create deployment logger --image=nginx
kubectl logs deploy/logger
```

---

## 🩺 Step 2 – Liveness and Readiness Probes
Apply this pod manifest:
```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 3
  periodSeconds: 5
```
Monitor with:
```bash
kubectl describe pod <name>
```

---

## 🧭 Step 3 – Monitor Events
```bash
kubectl get events
kubectl describe pod logger
```

---

## 📊 Step 4 – Metrics with kubectl top
```bash
kubectl top nodes
kubectl top pods
```
💡 Ensure `metrics-server` is deployed in your cluster

---

## 🔍 Step 5 – Explore Audit Logging
While not configured by default in Kind, review documentation:
https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/

Understand audit policy, backends, and filtering rules.

---

## 🧼 Cleanup
```bash
kubectl delete ns lab7-observability
```

✅ End of Lab 7 – You’ve explored logging, events, metrics, probes, and audit logging
