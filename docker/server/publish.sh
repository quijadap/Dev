#!/usr/bin/env bash

TAG=$1
GIT_TAG=snapshot/1.0.0
REGISTRY=nexus.cgtscorp.com:8080

docker push $REGISTRY/tvs-reception:$TAG

#git tag $GIT_TAG
