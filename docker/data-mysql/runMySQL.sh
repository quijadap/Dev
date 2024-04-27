#!/usr/bin/env bash

TAG=1.0.0

P_DB=33306
P_ENT=33306
DOCKER_REGISTRY=quijadap

docker stop db-mysql
docker rm db-mysql
docker run --name db-mysql -e MYSQL_ROOT_PASSWORD=L4b0n1t4*  -p $P_DB:$P_ENT -d $DOCKER_REGISTRY/db-mysql:$TAG;

docker logs -f db-mysql
