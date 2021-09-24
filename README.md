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

## Terraform
Use this for demo with Kubernetes Provisiong using Terraform.
[https://github.com/sarubhai/tf_kubernetes](https://github.com/sarubhai/tf_kubernetes)
