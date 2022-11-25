#!/bin/bash
PURPLE="\033[1;35m"
RED="\033[1;31m"
GREEN="\033[1;32m"
ORANGE="\033[1;33m"
NC="\033[0m"

RunCommand () {
  echo "${PURPLE}STEP: $1 ${NC}"
  read -p "Continue: ?" choice
  echo "Command: ${ORANGE} $2 ${NC}"
  if [ "$choice" = "n" ] || [ "$choice" = 'N' ]; then
    echo "SKIPPED"
  else
    if $2; then
      echo "Status: ${GREEN}SUCCESS!${NC}"
    else
      echo "Status: ${RED}FAILED!${NC}"
    fi
  fi
  echo
}
trap_ctrlc() {
    kill $pid
    wait $pid
}

trap trap_ctrlc INT
# PART 1
RunCommand "To create a local kubernetes cluster using k3d" "k3d cluster create local"
RunCommand "Check cluster info" "kubectl cluster-info"
RunCommand "Get nodes" "kubectl get no"
RunCommand "Deploy dashboard" "kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml"
RunCommand "Create admin user with required permissions" "kubectl create -f ../k8s/dashboard/dashboard-admin-user.yaml -f ../k8s/dashboard/dashboard-admin-user-role.yml"
RunCommand "Run kubectl proxy" "kubectl proxy 2>&1 &"
RunCommand "Create token for admin user" "kubectl -n kubernetes-dashboard create token admin-user"
echo "\nOpen dashboard here: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
# PART 2
RunCommand "Run docker image" "docker run harshasridhar/flask-sample-app:v1.0.0"
RunCommand "Run docker image with port mapping" "docker run -p 8000:8000 harshasridhar/flask-sample-app:v1.0.0"
# PART 3
RunCommand "Build docker image" "docker build -t flask-sample-app:v1.0.1 ../app"
RunCommand "Run docker image with port mapping" "docker run -p 8000:8000 flask-sample-app:v1.0.1"
# PART 4
RunCommand "Run docker image on Kubernetes pod" "kubectl create -f ../k8s/app/flask-sample-app-pod.yaml"
RunCommand "Delete the running Kubernetes pod" "kubectl delete -f ../k8s/app/flask-sample-app-pod.yaml"
# PART 5
RunCommand "Run docker image on kubernetes as deployment" "kubectl create deployment flask-sample-app --image=docker.io/harshasridhar/flask-sample-app:v1.0.0"
RunCommand "Expose service via Load Balancer" "kubectl expose deployment flask-sample-app --type LoadBalancer --port 8000 --target-port 8000"
RunCommand "Check the service for ip details" "kubectl get svc"
RunCommand "Delete the service" "kubectl delete svc flask-sample-app"
RunCommand "Delete the running Kubernetes deployment" "kubectl delete deployment flask-sample-app"
# PART 6
RunCommand "Deploy Kubernetes deployment from yaml" "kubectl create -f ../k8s/app/flask-sample-app-deployment.yaml"
RunCommand "Check deployments" "kubectl get deployment"
RunCommand "Deploy Kubernetes Service from yaml" "kubectl create -f ../k8s/app/flask-sample-app-service.yaml"
RunCommand "Check services" "kubectl get svc"
RunCommand "Delete the deployment and service" "kubectl delete -f ../k8s/app/flask-sample-app-deployment.yaml -f ../k8s/app/flask-sample-app-service.yaml"
# PART 7
RunCommand "Copy local docker image to k3d cluster" "k3d image import flask-sample-app:v1.0.1 -c local"
RunCommand "Create a ConfigMap" "kubectl create -f ../k8s/app/configmap.yaml"
RunCommand "Deploy the app with configmap" "kubectl create -f ../k8s/app/flask-sample-app-with-configmap-deployment.yaml -f ../k8s/app/flask-sample-app-service.yaml"
RunCommand "Delete all the resources created" "kubectl delete -f ../k8s/app/flask-sample-app-service.yaml -f ../k8s/app/flask-sample-app-with-configmap-deployment.yaml -f ../k8s/app/configmap.yaml"
# PART 8
RunCommand "Create a Secret" "kubectl create -f ../k8s/app/secret.yaml"
RunCommand "Deploy the app with secret" "kubectl create -f ../k8s/app/flask-sample-app-with-secret-deployment.yaml -f ../k8s/app/flask-sample-app-service.yaml"
RunCommand "Delete all the resources" "kubectl delete -f ../k8s/app/flask-sample-app-with-secret-deployment.yaml -f ../k8s/app/flask-sample-app-service.yaml -f ../k8s/app/secret.yaml"

RunCommand "Stop the local k3d cluster" "k3d cluster stop local"
RunCommand "Delete the loca k3d cluster" "k3d cluster delete local"