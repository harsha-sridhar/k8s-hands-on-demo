# Running Local Image on Kubernetes

Assuming that you have built the docker image locally

## Import the image into k3d
Run the following command
```shell
$ k3d image import imagename:tag -c clustername
```

## Deploy the service on k8s cluster
```shell
$ kubectl create deployment deployment-name --image=imagename:tag
deployment.apps/deployment-name created
```
You can check the details using the following command
```shell
$ kubectl get deployment
```

## Expose the deployment
Run the following command:
```shell
$ kubectl expose deployment deployment-name --type LoadBalancer --port 8000 --target-port 8000
```
`target-port` refers to the port the application is listening to

## Get the service details
The following command will output the external ip
```shell
$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   20m
```

## Make an API call to the application
```shell
$ curl <service-ip>:8000
```