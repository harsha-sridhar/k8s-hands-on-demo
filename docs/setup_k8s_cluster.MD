# Setup Kubernetes Cluster

## Option 1 - minikube
### Start cluster
```shell
minikube start
```
This will create a local cluster
### Start Kubernetes Dashboard
```shell
minikube dashboard
```
This will deploy a dashboard

## Option 2 - k3d
### Create Cluster
```shell
k3d cluster create cluster-name
```

### Deploy Kubernetes dashboard
Follow steps listed [here](configure-kubernetes-dashboard.MD)