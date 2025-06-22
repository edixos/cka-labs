# 🧪 Lab – Core Workloads & Configuration Management (Module 4)

## 🎯 Objectives

- Create and scale applications using **Deployments**
- Simulate **rolling updates and rollbacks**
- Deploy a **StatefulSet** and observe stable identities and storage
- Implement **liveness** and **readiness probes**
- Use **ConfigMaps** and **Secrets** to inject configuration into pods

---

## 🔧 Prerequisites

- A running **Kind cluster** with access to `kubectl`
- Namespace `module4-lab` created:
  ```bash
  kubectl create ns module4-lab
  kubectl config set-context --current --namespace=module4-lab
  ```

---

## 🛠️ Step 1 – Create a Deployment

- Create a deployment named `webapp` with 3 replicas of `nginx`
- Expose port 80

```bash
kubectl create deployment webapp \
  --image=nginx --replicas=3 \
  --dry-run=client -o yaml > deployment.yaml
kubectl apply -f deployment.yaml
kubectl expose deployment webapp --port=80 --target-port=80
```

---

## 🔁 Step 2 – Simulate a Rolling Update & Rollback

- Update image to a newer version or invalid one
- Observe rollout behavior and rollback

```bash
kubectl set image deployment/webapp nginx=nginx:1.25
kubectl rollout status deployment/webapp
kubectl rollout undo deployment/webapp
```

---

## 📦 Step 3 – Deploy a StatefulSet

- Create a `StatefulSet` with headless service, and PVC
- Observe pod names and volume claims

```bash
kubectl apply -f statefulset.yaml  # Provided in repo
kubectl get pods -o wide
kubectl get pvc
```

---

## 🩺 Step 4 – Add Liveness and Readiness Probes

- Patch the deployment or create a new one with HTTP probes on port 80

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

Apply and observe pod status using `kubectl describe pod`

---

## 🔐 Step 5 – Inject Configuration with ConfigMap and Secret

```bash
kubectl create configmap app-config --from-literal=ENV=production
kubectl create secret generic db-creds \
  --from-literal=username=admin --from-literal=password=passw0rd
```

Mount into pod or expose via env vars:
```yaml
envFrom:
  - configMapRef:
      name: app-config
  - secretRef:
      name: db-creds
```

---

## 🧼 Cleanup

```bash
kubectl delete ns module4-lab
```

---

✅ End of Lab – You’ve practiced core workloads, self-healing, and config injection!
