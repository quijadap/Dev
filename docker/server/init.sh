#!/usr/bin/env bash

sh ./../ldap/runDockerLdap.sh
docker start rabbit1 rabbit2 rcl-db rcl-web
sh deploy.sh