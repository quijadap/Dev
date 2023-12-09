#!/usr/bin/env bash
#TAG=FM_1.8
TAG=PQ_1.0
#TAG=QA_1.8
REGISTRY=nexus.cgtscorp.com:8080

#rm tvs-reception.war
#cp ../../dist/tvs-reception-war/target/tvs-reception.war .

docker stop tvs-evoting
docker rm tvs-evoting
docker rmi -f $(docker images | grep tvs-evoting | awk "{print \$3}")
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

docker build -t $REGISTRY/tvs-evoting:$TAG .







