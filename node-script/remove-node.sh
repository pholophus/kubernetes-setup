#!/bin/bash

set -euxo pipefail

# Step 1: Delete Kubernetes cluster
sudo kubeadm reset -f

# Step 2: Remove Kubernetes binaries
sudo apt-get purge kubeadm 
sudo apt-get purge kubelet 
sudo apt-get purge kubectl 
sudo apt-get purge kubernetes-cni
sudo apt-get purge kube*
sudo apt-get autoremove -y

# Step 3: Remove related files and directories
sudo rm -rf ~/.kube /etc/cni /etc/kubernetes /etc/apparmor.d/docker /etc/systemd/system/etcd* /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/lib/etcd2/ /var/run/kubernetes

# Step 4: Clear out firewall tables and rules
sudo iptables -F && sudo iptables -X
sudo iptables -t nat -F && sudo iptables -t nat -X
sudo iptables -t raw -F && sudo iptables -t raw -X
sudo iptables -t mangle -F && sudo iptables -t mangle -X


# Step 5: Optional - Remove Docker
docker image prune -a -f
sudo systemctl restart docker
sudo apt purge docker-engine docker docker.io docker-ce docker-ce-cli containerd containerd.io runc --allow-change-held-packages -y
sudo apt autoremove -y
sudo groupdel docker

# Step 6: Remove Kubernetes configuration files
sudo rm -rf /etc/kubernetes
sudo rm -rf ~/.kube

# Step 7: Reload systemd manager
sudo systemctl daemon-reload
