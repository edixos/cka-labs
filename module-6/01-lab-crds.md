# 03🧪 Lab 6.2 – Working with CRDs

## 🎯 Objectives
- Discover existing CRDs
- Create a simple CustomResourceDefinition and Custom Resource

---

## 🔍 Step 1 – Discover Installed CRDs
```bash
kubectl get crds
kubectl explain <crd-name>
```

---

## ✍️ Step 2 – Define a Simple CRD
```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: widgets.demo.k8s.io
spec:
  group: demo.k8s.io
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                size:
                  type: string
  scope: Namespaced
  names:
    plural: widgets
    singular: widget
    kind: Widget
```

Apply with:
```bash
kubectl apply -f widget-crd.yaml
```

---

## ➕ Step 3 – Create a Custom Resource
```yaml
apiVersion: demo.k8s.io/v1
kind: Widget
metadata:
  name: my-widget
spec:
  size: large
```
```bash
kubectl apply -f widget.yaml
kubectl get widget
```

✅ End of Lab 6.2 – You’ve created and interacted with custom Kubernetes API objects
