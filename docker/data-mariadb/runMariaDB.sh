#!/usr/bin/env bash

TAG=1.0.0

P_DB=34306
P_ENT=34306
DOCKER_REGISTRY=quijadap

docker stop db-mariadb
docker rm db-mariadb
docker run --name db-mariadb -e MARIADB_ROOT_PASSWORD=L4b0n1t4*  -p $P_DB:$P_ENT -d $DOCKER_REGISTRY/db-mariadb:$TAG;

docker logs -f db-mariadb
