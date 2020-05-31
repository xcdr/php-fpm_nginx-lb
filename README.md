# README

Example Docker deployment of php-fpm + nginx load balancer / static server.

This is very simple example of php-fpm app servers and one nginx load balancer.

Sources are on shared volume accessible for all containers, nginx also serve static files.

This is not perfect setup, better result is possible with Nginx Plus or Traefik as load balancer.

## Deploy app:

    docker-compose up --build --detach --scale php-fpm=2

## Scale app:

    docker-compose up --scale php-fpm=4

## Test app:


Static content:

    curl -o - http://localhost:8080

Dynamic content:

    curl -o - http://localhost:8080/index.php

Logs of load balancer:

    docker-compose logs nginx-lb

## Tear down

    docker-compose down
