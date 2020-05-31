# README

Example Docker deployment of php-fpm + nginx / static server.

This is very simple example:
* for Docker php-fpm scalable app servers and nginx as load balancer / static server.
* for K8s php-fpm app server and nginx as FastCGI forwarder and static file server in one pod.

Sources and static files are on shared persistent volume accessible for all containers.

Shared storage is for example, in real world each container should have own files but sometimes silly thing happens.

This is not perfect setup, better result is possible with Nginx Plus or Traefik as load balancer, especially for Docker.

## Build:

    make && make docker-push

## Deploy app:

Docker:

    docker-compose up --detach --scale php-fpm=2

K8s:

    kubectl apply -f minikube-volume.yml
    kubectl apply -f minikube-volume-claim.yml
    kubectl apply -f minikube-deployment.yml
    kubectl apply -f minikube-service.yml

    # copy app files (stupid version for example only)
    kubectl apply -f minikube-dummy-storage.yml
    kubectl cp app-files/index.txt dummy-storage:/mnt/app-data/
    kubectl cp app-files/index.php dummy-storage:/mnt/app-data/
    kubectl delete -f minikube-dummy-storage.yml

## Scale app:

Docker:

    docker-compose up --detach --scale php-fpm=4

K8s:

    kubectl scale --replicas=4 -f minikube-deployment.yml

## Test app:


Static content:

    curl -o - http://localhost:8080 # docker
    curl -o - http://<your cluster ip>:8080 # minikube

Dynamic content:

    curl -o - http://localhost:8080/index.php # docker
    curl -o - http://<your cluster ip>:8080/index.php # minikube


Logs of load balancer:

    docker-compose logs nginx-lb

    # before display logs You must know pod name via command: kubectl get pods
    kubectl logs web-app-deployment-<pod suffix> nginx

## Tear down:

Docker:

    docker-compose down

K8s:

    kubectl delete -f minikube-service.yml
    kubectl delete -f minikube-deployment.yml
    kubectl delete -f minikube-volume-claim.yml
    kubectl delete -f minikube-volume.yml

## Tips:

For minikube important is:
* `minikube ssh` and `sudo mkdir /mnt/app-data` before deploy
* `minikube tunnel` because this allow forward external endpoint to cluster IP.
