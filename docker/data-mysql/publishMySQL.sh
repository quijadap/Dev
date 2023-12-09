#!/usr/bin/env bash

TAG=1.0.0
GIT_TAG=snapshot/1.0.0
REGISTRY=quijadap  

#./build.sh

docker push $REGISTRY/db-mysql:$TAG

#git tag $GIT_TAG
