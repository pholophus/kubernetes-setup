#!/bin/bash

set -euxo pipefail

# Step 1: Delete Kubernetes cluster
sudo kubeadm reset

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
kubectl delete -f https://docs.projectcalico.org/manifests/calico.yaml || true

# Step 6: Clear iptables rules
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X