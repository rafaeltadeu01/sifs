#!/bin/bash

sudo apt update
sudo apt -y install curl apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install kubelet kubeadm kubectl -y 
sudo apt-mark hold kubelet kubeadm kubectl

kubectl version --client && kubeadm version

sudo swapoff -a; sudo sed -i '/swap/d' /etc/fstab

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

sudo apt update
sudo apt install curl gnupg2 software-properties-common apt-transport-https ca-certificates -y 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install containerd.io docker-ce docker-ce-cli -y 

sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

[Quebrado]
. /etc/os-release
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O- | sudo apt-key add -
sudo apt update

sudo apt install cri-o-1.17
sudo systemctl daemon-reload
sudo systemctl start crio
sudo systemctl enable crio
[Quebrado]

Configure persistent loading of modules
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install containerd.io -y

sudo mkdir -p /etc/containerd
sudo su -
containerd config default  /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

lsmod | grep br_netfilter
br_netfilter           22256  0 
bridge                151336  2 br_netfilter,ebtable_broute

sudo systemctl enable kubelet

sudo kubeadm config images pull

sudo kubeadm init \
  --pod-network-cidr=172.16.0.0/16 \
  --control-plane-endpoint=k8s-m1

#################### Saida do comando ##################################
You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join k8s-m1:6443 --token 415zma.aeic5rhaxqoa1zfc \
        --discovery-token-ca-cert-hash sha256:9c9a665b99fa1fedb0de25f8bcbde946d51726ad6a0cdc2d9aa6fd38cc978d6e \
        --control-plane

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join k8s-m1:6443 --token 415zma.aeic5rhaxqoa1zfc \
        --discovery-token-ca-cert-hash sha256:9c9a665b99fa1fedb0de25f8bcbde946d51726ad6a0cdc2d9aa6fd38cc978d6esud
#################### Saida do comando ##################################


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

watch kubectl get pods --all-namespaces
kubectl get nodes -o wide