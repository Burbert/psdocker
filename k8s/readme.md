# Usage
This Kubernetes deployment is meant to be used on a Azure Kubernetes Services Cluster.<br>
It creates two k8s objects, a public facing load balancer and a deployment using the [microservice](https://github.com/Burbert/psdocker/tree/main/container/microservice) docker image from this repo.<br>
This is an exmple and for education purposes only, do not use this in a production environment.

```Powershell
kubectl apply -f 'https://raw.githubusercontent.com/Burbert/psdocker/main/k8s/deploy.yaml'
```
