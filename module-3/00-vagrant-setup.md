# 🧰 00 – Vagrant Setup for Local Lab Environment

> ⚙️ This setup is intended for users running **Ubuntu 24.04** on a physical machine who want to simulate a Kubernetes cluster using two VMs.

---

## 🎯 Objectives
- Install **VirtualBox** and **Vagrant**
- Set up 2 Ubuntu VMs with private network access
- Prepare environment for use with kubeadm lab

---

## 🧱 Step 1: Install Dependencies

```bash
sudo apt update
sudo apt install -y virtualbox vagrant
```

Verify installations:
```bash
vagrant --version
virtualbox --help | head -n 1
```

---

## 🗂️ Step 2: Create Project Folder

```bash
mkdir -p ~/k8s-lab && cd ~/k8s-lab
```

---

## 📄 Step 3: Create `Vagrantfile`

Create a file named `Vagrantfile` with the following content:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/24.04"

  ["master", "worker"].each do |hostname|
    config.vm.define hostname do |node|
      node.vm.hostname = hostname
      node.vm.network "private_network", type: "dhcp"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end
      node.vm.provision "shell", inline: <<-SHELL
        apt update && apt install -y curl apt-transport-https
      SHELL
    end
  end
end
```

---

## 🚀 Step 4: Start the VMs

```bash
vagrant up
```

This will download the base image (first time only) and create two VMs: `master` and `worker`.

---

## 🔎 Step 5: SSH into VMs

```bash
vagrant ssh master
```

In another terminal:
```bash
vagrant ssh worker
```

---

## 🧼 Teardown (Optional)

To stop and delete all VMs:
```bash
vagrant destroy -f
```

To suspend (save state):
```bash
vagrant suspend
```

---

## ✅ What's Next?
Use these two VMs for the **kubeadm lab** where you’ll bootstrap a Kubernetes control plane and join a worker node.