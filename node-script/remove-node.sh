#!/bin/bash

VERSION="1.28"

set -euxo pipefail

# Step 1: Delete Kubernetes cluster
sudo kubeadm reset

# kubectl delete -f https://docs.projectcalico.org/manifests/calico.yaml || true

# kubectl delete -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

# Step 2: Remove Kubernetes binaries
sudo apt-get purge kubeadm 
sudo apt-get purge kubelet 
sudo apt-get purge kubectl 
sudo apt-get autoremove -y

# Step 3: Remove Docker (if installed)
sudo apt-get purge docker-ce docker-ce-cli containerd.io -y
sudo rm -rf /var/lib/docker

# Step 4: Remove Kubernetes configuration files
sudo rm -rf /etc/kubernetes
sudo rm -rf ~/.kube

# Step 5: Remove Calico network plugin (if installed)

# Step 6: Uninstall Cri-O and remove its configuration
sudo apt-get purge cri-o cri-o-runc -y
sudo systemctl stop crio
sudo systemctl disable crio
sudo rm /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
sudo rm /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
sudo rm /etc/apt/trusted.gpg.d/libcontainers.gpg

# Step 7: Update APT
sudo apt-get update

# Step 8: Clear iptables rules
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X
