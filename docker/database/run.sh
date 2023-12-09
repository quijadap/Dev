#!/usr/bin/env bash

TAG=1.0.0

P_DB=1521
P_ENT=5500
DOCKER_REGISTRY=quijadap

docker stop tvs-evoting-db
docker rm tvs-evoting-db
docker run --name tvs-evoting-db -p $P_DB:1521  -p $P_ENT:5500 -e ORACLE_CHARACTERSET=utf8 -d $DOCKER_REGISTRY/tvs-evoting-db:$TAG;

docker logs -f tvs-evoting-db
