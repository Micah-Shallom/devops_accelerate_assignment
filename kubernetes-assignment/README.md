# Deploying application on kubernetes

Source Code : https://github.com/nlharri/simple-todo-app-mongodb-express-node

#
## Find All Deployment Code [Here](./K8s/)
#

Created dockercompose file to test configuration

![](./screenshots/1.docker-compose_file.jpg)

Fixed database connection for app to connect with 

![](./screenshots/2.reorganized_db_setup.jpg)

Application runs well on basic docker containers

![](./screenshots/docker-compose-run.jpg)

Application Setup with Kubernetes Manifest

![](./screenshots/manifest_files.jpg)

## Cluster Deployment
#

Wrote helm chart deployment for application

![](./screenshots/4.helm_deploy.jpg)

Running application

![](./screenshots/5.deploy_success.jpg)

Creating new namespaces for each stage

![](./screenshots/6.dev_namespace_deploy.jpg)

All deployed environments

![](./screenshots/7.all_env.jpg)

Successfull ArgoCD app synchronization 

https://user-images.githubusercontent.com/64049432/189550249-dbda371f-68f7-4ff4-ae3e-d481a222cd53.mp4

