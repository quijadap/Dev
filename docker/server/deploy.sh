#!/usr/bin/env bash

echo "Deployment TVS war"

docker cp conf/ tvs-evoting:/usr/local/tomcat/conf/

docker cp props/ tvs-evoting:/usr/local/tomcat/tvs/props/

docker cp tvs-evoting.war tvs-evoting:/usr/local/tomcat/webapps


echo "Stoping Container"

docker stop tvs-evoting

echo "Starting Container"

docker start tvs-evoting

docker logs --tail 1000 -f tvs-evoting
