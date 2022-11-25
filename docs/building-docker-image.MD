# Running Flask Application on Docker

## Steps
- Make sure you have a `requirements.txt` file where all the requirements for the application are listed.
 You can also prepare this file by running:
```shell
$ pip freeze > requirements.txt
```
- Prepare the Dockerfile
Dockerfile for a sample flask application is as follows:
[Dockerfile](../app/Dockerfile)
- Build the docker image
Remember to run this command from app/ else update `.` in the command to the path
```shell
$ docker build -t flask-sample-app:v1.0.0 .
```
- Run docker image 
```shell
docker run flask-sample-app:v1.0.0
```
In case port fowarding is required, run the following command:
```shell
docker run -p 8000:8000 flask-sample-app:v1.0.0
```

- [Optional] Push image to registry
  - Tag the built docker image with the container registry url and tag
  ```shell
  $ docker tag flask-sample-app:v1.0.0 user-name/repo-name:version
  ```
  - Login to docker hub (One of the options)
  ```shell
  $ docker login
  This prompts for username and password for docker hub
  ```
  - Push the docker image to the container registry
  ```shell
  $ docker push user-name/repo-name:version
  ```