
# 02🧪 Lab 6.1 – Scheduling: nodeSelector, Affinity, Taints

## 🎯 Objectives
- Practice manual pod placement using `nodeSelector`
- Apply node affinity and anti-affinity rules
- Use taints and tolerations to restrict scheduling

---

## 🔧 Prerequisites
- A running **Kind cluster**
- Label a node:
  ```bash
  kubectl label node <node-name> disktype=ssd zone=east
  ```

---

## 📍 Step 1 – Manual Pod Placement with nodeSelector
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: manual-pod
spec:
  containers:
  - name: nginx
    image: nginx
  nodeSelector:
    disktype: ssd
```

---

## 🧲 Step 2 – Node Affinity & Anti-Affinity
```yaml
nodeAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
    - matchExpressions:
      - key: zone
        operator: In
        values:
        - east
```

Use `preferredDuringSchedulingIgnoredDuringExecution` for soft rules.

Anti-affinity:
```yaml
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchLabels:
          app: nginx
      topologyKey: "kubernetes.io/hostname"
```

---

## 🚫 Step 3 – Taints & Tolerations
Apply taint:
```bash
kubectl taint node <node-name> dedicated=web:NoSchedule
```
Pod with toleration:
```yaml
tolerations:
- key: "dedicated"
  operator: "Equal"
  value: "web"
  effect: "NoSchedule"
```

---

## 🧼 Cleanup
```bash
kubectl delete pod manual-pod
kubectl taint node <node-name> dedicated:NoSchedule-
```

✅ End of Lab 6.1 – You’ve controlled pod scheduling using advanced rules