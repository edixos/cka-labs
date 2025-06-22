# 💪 Lab 5.2 – Gateway API & Ingress Routing

## 🌟 Objectives
- Install a **Gateway API** controller and create an `HTTPRoute`
- Install an **Ingress controller** and configure an `Ingress` resource
- Route traffic to the **same app** via **Gateway and Ingress**

---

## 🔧 Environment Setup (Kind + Host Mapping)

### 1. Create Kind Cluster with extraPortMappings
```yaml
# kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 8080
        protocol: TCP
```
```bash
kind create cluster --name lab5-gw-ing --config kind-config.yaml
```

### 2. Add /etc/hosts Entry (example)
```bash
echo "127.0.0.1 demo.k8s.local" | sudo tee -a /etc/hosts
```

---

## 🌐 Step 1 – Deploy Sample App
```bash
kubectl create deployment webapp --image=nginx -n default
kubectl expose deployment webapp --port=80 --target-port=80
```

---

## 🚪 Step 2 – Gateway API Installation (e.g., Envoy Gateway or Traefik)
Refer to:
https://gateway-api.sigs.k8s.io/guides/

Install Gateway CRDs + controller, then:
```yaml
# gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: demo-gateway
spec:
  gatewayClassName: <your-class>
  listeners:
  - name: http
    port: 80
    protocol: HTTP
    hostname: demo.k8s.local
```

```yaml
# httproute.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: demo-route
spec:
  parentRefs:
    - name: demo-gateway
  hostnames:
    - demo.k8s.local
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: webapp
          port: 80
```

---

## 🌍 Step 3 – Ingress Controller Setup (e.g., ingress-nginx)
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx
```

Create the Ingress:
```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-ingress
spec:
  rules:
    - host: demo.k8s.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: webapp
                port:
                  number: 80
```

---

## ✅ Test
```bash
curl http://demo.k8s.local:8080
```
Switch between Gateway/Ingress by applying or deleting their resources.

---

## 🫼 Cleanup
```bash
kind delete cluster --name lab5-gw-ing
sudo sed -i '' '/demo.k8s.local/d' /etc/hosts
```

📅 End of Lab 5.2 – You've deployed HTTP routing with Gateway API and Ingress
