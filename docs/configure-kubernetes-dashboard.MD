# Configure Kubernetes dashboard
Reference: [https://gist.github.com/smijar/64e76808c8a349eb64f56c71dc03d8d8](https://gist.github.com/smijar/64e76808c8a349eb64f56c71dc03d8d8)
## Deploy kubernetes-dashboard
Run the following command:
```shell
GITHUB_URL=https://github.com/kubernetes/dashboard/releases
VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
```

## Add admin user and bind appropriate permissions
Service account details can be found [here](../k8s/dashboard/dashboard-admin-user.yaml) <br/>
Role Binding details can be found [here](../k8s/dashboard/dashboard-admin-user-role.yml)
```shell
$ kubectl create -f dashboard-admin-user.yaml -f dashboard-admin-user-role.yml
```

## Create a token for user
```shell
$ kubectl -n kubernetes-dashboard create token admin-user
```
This command will output a token copy that token

## Run the kubectl proxy
```shell
$ kubectl proxy
```

## Open the dashboard
[Dashboard URL](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/) <br/>
The dashboard will prompt for a <b>Token</b> or <b>Kubeconfig</b><br/>
Select token and paste generated token and login.