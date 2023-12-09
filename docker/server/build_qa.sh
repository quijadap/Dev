#!/usr/bin/env bash

TAG=$1
REGISTRY=nexus.cgtscorp.com:8080

#rm tvs-reception.war
#cp ../../dist/tvs-reception-war/target/tvs-reception.war .

docker stop tvs-reception
docker rm tvs-reception
docker rmi -f $(docker images | grep tvs-reception | awk "{print \$3}")
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

cp ././../../app/tvs-reception/target/tvs-reception.war .

docker build -t $REGISTRY/tvs-reception:$TAG .







