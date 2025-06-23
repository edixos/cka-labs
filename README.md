# 🧪 CKA Training Labs

“Kubernetes Certified Kubernetes Administrator (CKA) training labs repository for hands-on practice and exercises.”

**Level**: Intermediate to Advanced
**Topics**: Kubernetes, CKA, Cluster Bootstrapping, Workloads, Networking, Storage, Access Control, Troubleshooting
**License**: MIT License
**Version**: 1.32.x

# CKA Training Labs Repository

Welcome to the Kubernetes training lab repository. This repo contains practical exercises and manifests structured by module to help trainees gain hands-on experience with core Kubernetes concepts including cluster bootstrapping, workloads, networking, storage, access control, and troubleshooting.

## 🗂️ Repository Structure

```
├── module-1
│   └── manifests
├── module-2
│   ├── assets
│   └── manifests
│       ├── cni
│       └── csi
├── module-3
│   └── manifests
├── module-4
│   └── manifests
├── module-5
│   └── manifests
├── module-6
├── module-7
└── module-8
```

Each module includes Markdown lab instructions and optional Kubernetes manifests.

## 🚀 Getting Started

To work with these labs:

1. Clone the repository:

   ```bash
   git clone https://github.com/<your-org>/k8s-labs.git
   cd k8s-labs
   ```

2. Follow the instructions in each module’s `README.md` or main lab Markdown file.

3. Use a local Kubernetes cluster such as [Kind](https://kind.sigs.k8s.io/) or a cloud provider-managed cluster (e.g., GKE, AKS, EKS).

## 📚 Topics Covered

* 📦 Module 1: Kubeadm & Cluster Bootstrapping
* 🔐 Module 2: RBAC, ServiceAccounts, and Security Contexts
* ⚙️ Module 3: Static Pods, Node Affinity, and Taints
* 🚀 Module 4: Deployments, Probes, StatefulSets, ConfigMaps & Secrets
* 🌐 Module 5: Services, CoreDNS, Ingress & Gateway API
* 📦 Module 6: Storage and CSI Drivers
* 🧑‍🔧 Module 7: Troubleshooting & Logging
* 📈 Module 8: Observability & Monitoring

## 📎 License

This training content is provided under the [MIT License](LICENSE).

## 🤝 Contributing

PRs and feedback are welcome! If you're an instructor or contributor, feel free to submit improvements or fixes.

---

📬 For questions or suggestions, please contact \[your-name or org] at \[your-contact-email].
