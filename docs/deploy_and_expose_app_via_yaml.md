# Deploy and Expose app via yaml

## Create a deployment yaml file
Refer to the deployment file [here](../k8s/app/flask-sample-app-deployment.yaml)

## Create a service yaml file
Refer to the service file [here](../k8s/app/flask-sample-app-service.yaml)

## Create the deployment and service
```shell
$ kubectl create -f deployment.yaml -f service.yaml
```

## Get the service details
```shell
$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   20m
```

## Make an API call to the application
```shell
$ curl <service-ip>:<port>
```

## Delete the deployment and service
```shell
$ kubectl delete -f service.yaml -f deployment.yaml
```