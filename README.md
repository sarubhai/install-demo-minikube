# install-demo-minikube
Install Standalone Minikube Server for Demo

- OS: Ubuntu 20.04 LTS
- Minikube: 1.23.1
- Min Spec: 2 CPUs; 2GB RAM; 20GB disk space

### UserData Config Usage

```
#!/bin/bash
curl -O https://raw.githubusercontent.com/sarubhai/install-demo-minikube/master/minikube_install.sh
chmod +x minikube_install.sh
./minikube_install.sh

```

To Access Kubernetes Dashboard, map the <ipaddress> of the node to domin [minikube.demo](minikube.demo) in your /etc/hosts file.

xxx.xxx.xxx.xxx   minikube.demo

Then access the url [https://minikube.demo](https://minikube.demo) from your browser.

## Terraform
Use this for demo with Kubernetes Provisiong using Terraform.

Refer:
[https://github.com/sarubhai/tf_kubernetes](https://github.com/sarubhai/tf_kubernetes)
