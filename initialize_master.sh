#!/bin/bash

# Variables
MASTER_IP="192.168.50.10"  # Remplacez par l'adresse IP de votre machine master
WORKER_IP="192.168.50.11"  # Remplacez par l'adresse IP de votre machine worker
SSH_WORKER_USER="vagrant"  # Remplacez par le nom d'utilisateur de votre machine worker
WORKER_PSW="vagrant"  # Remplacez par le mot de passe de votre machine worker

sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo kubeadm reset -f
sudo swapoff -a

# Initialize the control plane on the master node as the root user
sudo kubeadm init --control-plane-endpoint=k8s-master --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=${MASTER_IP} --ignore-preflight-errors=all

# Set up kubeconfig as normal ubuntu user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy the network plugin (calico network)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Generate token and show join command
JOIN_CMD=$(sudo kubeadm token create --print-join-command)

# Print the join command (copy this command to run it on the worker node)
echo "On the worker node, run the following command:"
echo "${JOIN_CMD}"

# Install sshpass if not installed
sudo apt-get install -y sshpass

# Join worker node to Kubernetes cluster
sshpass -p "${WORKER_PSW}" ssh -o StrictHostKeyChecking=no ${SSH_WORKER_USER}@${WORKER_IP} sudo $JOIN_CMD

sleep 5
#Check if all nodes are ready

while kubectl get nodes | grep "NotReady";
do
        echo "Tous les noeuds ne sont pas prêts";
        sleep 5;
done
        echo "Les noeuds sont désormais prêts";


kubectl apply -f ./database/deployment.yaml
kubectl apply -f ./database/service.yaml

# Attendre quelques instants pour que la base de données soit prête
sleep 30

# Déployer l'application
kubectl apply -f ./app/deployment.yaml

# Verify that the worker node has joined the cluster successfully
kubectl get nodes -o wide