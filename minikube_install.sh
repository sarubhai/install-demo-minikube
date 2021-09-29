#!/bin/bash
# Name: minikube_install.sh
# Owner: Saurav Mitra
# Description: Install & Configure Kubernetes Minikube server for demo
# OS: Ubuntu 20.04 LTS
# Minikube: 1.23.1
# Min Spec: 2 CPUs; 2GB RAM; 20GB disk space

sudo apt-get --assume-yes --quiet update                                        >> /dev/null
sudo apt-get --assume-yes --quiet install apt-transport-https curl conntrack    >> /dev/null

# Install Docker
sudo apt-get --assume-yes --quiet install software-properties-common ca-certificates gnupg lsb-release  >> /dev/null

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get --assume-yes --quiet update                                >> /dev/null
sudo apt-get --assume-yes --quiet install docker-ce=5:20.10.8~3-0~ubuntu-focal docker-ce-cli=5:20.10.8~3-0~ubuntu-focal containerd.io   >> /dev/null

# Install Minikube
cd /root
export MINIKUBE_HOME="/root/.minikube"
export CHANGE_MINIKUBE_NONE_USER=true

sudo curl -s -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod 755 /usr/local/bin/minikube
sudo sysctl fs.protected_regular=0

minikube start --driver=none --network-plugin=cni --cni='cilium' --addons ingress --addons dashboard --addons metrics-server     >> /dev/null
minikube config set driver none     >> /dev/null
sudo chown -R root /root/.minikube
sudo chmod -R u+wrx /root/.minikube


# Install Kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo chown -R root /root/.kube/config


# Dashboard Ingress
sudo tee /root/dashboard-ingress.yaml &>/dev/null <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dashboard-ingress
  namespace: kubernetes-dashboard
  labels:
    name: dashboard-ingress
spec:
  rules:
  - host: minikube.demo
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: kubernetes-dashboard
            port: 
              number: 80
EOF

kubectl apply -f /root/dashboard-ingress.yaml


# Optional for Demo Only
# Local Volume
mkdir -p /data/pv-1
mkdir -p /data/pv-2
mkdir -p /data/pv-3
mkdir -p /data/pv-4
sudo chown -R root /data


# Demo Nginx Landing Page
sudo tee /data/pv-1/index.html &>/dev/null <<EOF
<html>
<head><title>Kubernetes | Nginx</title></head>
<body>
<h1>Welcome Home</h1>
<p>This Page is served from Nginx Container running in Kubernetes cluster.</p>
<h2>Greetings!</h2>
</body>
</html>
EOF
sudo chown -R root /data
