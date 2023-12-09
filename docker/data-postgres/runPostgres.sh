#!/usr/bin/env bash

TAG=1.0.0

P_DB=5432
P_ENT=5432
DOCKER_REGISTRY=quijadap

docker stop db-postgres
docker rm db-postgres
docker run --name db-postgres -p $P_DB:$P_ENT -d $DOCKER_REGISTRY/db-postgres:$TAG;

#docker run --name db-postgres -p $P_DB:1521  -p $P_ENT:5500 -e ORACLE_CHARACTERSET=utf8 -d $DOCKER_REGISTRY/db-postgres:$TAG;

docker logs -f db-postgres
