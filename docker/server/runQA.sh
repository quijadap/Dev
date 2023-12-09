#!/usr/bin/env bash

TAG=$1
P_WEB=8080
P_SEG=443
P_DEBUG=8787
P_MANAGER=9999

IP_BD=192.168.7.201
ip_rabbit1=rabbit1:192.168.7.203
ip_rabbit2=rabbit2:192.168.7.203
IP_BD_PORT=1522
DOCKER_REGISTRY=nexus.cgtscorp.com:8080
LDAPS=ldaps:192.168.7.204
export JAVA_OPTS="-Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=0.0.0.0:8000,suspend=n -server -Xms2048m -Xmx2048m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=1024m -Dapp.core.home=/usr/local/tomcat/tvs -DIP_DB_PORT=$IP_BD_PORT"

docker stop tvs-reception
docker rm tvs-reception
#docker rmi $DOCKER_REGISTRY/tvs-reception:$TAG

docker run --name tvs-reception -e JAVA_OPTS -p $P_WEB:8080 -p $P_DEBUG:8787 -p 8000:8000 -p $P_SEG:443 -p $P_MANAGER:9999 -v ~/tvs/proccesable:/opt/tvs/sender -v ~/tvs/tallies:/opt/tvs/tallies \
--add-host tvs-reception:$IP_BD --add-host $LDAPS --add-host tvs-database:$IP_BD --add-host $ip_rabbit1 --add-host $ip_rabbit2 -d $DOCKER_REGISTRY/tvs-reception:$TAG

docker logs -f tvs-reception
