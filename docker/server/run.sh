 #!/usr/bin/env bash

TAG=PQ_1.0
P_WEB=8082
P_SEG=444
P_DEBUG=8788
P_DEBUG2=8001
P_MANAGER=1000

IP_BD_PORT=1521
IP_BD=`hostname -I | cut -d ' ' -f 1`

export JAVA_OPTS="-Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=0.0.0.0:8000,suspend=n -server -Xms700m -Xmx1024m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=700m -Dapp.core.home=/usr/local/tomcat/tvs -DIP_DB_PORT=$IP_BD_PORT"

DOCKER_REGISTRY=nexus.cgtscorp.com:8080

docker stop tvs-evoting
docker rm tvs-evoting

docker run --name tvs-evoting -p $P_WEB:8080 -p $P_DEBUG:8787 -p $P_DEBUG2:8000 -p $P_SEG:443 -p $P_MANAGER:9999  \
-e JAVA_OPTS --add-host tvs-databases:$IP_BD -d $DOCKER_REGISTRY/tvs-evoting:$TAG

docker logs -f tvs-evoting
