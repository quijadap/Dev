FROM tomcat:9.0.30-jdk13-openjdk-oracle
MAINTAINER Pedro Quijada

#DEBUG
#ENV JPDA_ADDRESS="8000"
#ENV JPDA_TRANSPORT="dt_socket"
#ENV JPDA_SUSPEND="n"
#

#ENV JPDA_OPTS="-agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"
#ENV CATALINA_OPTS = "-Xms2048M -Xmx2048M -server -XX:+UseParallelGC"

#ENV JAVA_OPTS="$JAVA_OPTS -Xdebug –Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8787"

#ENV JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000"

#ENV JAVA_OPTS="$JAVA_OPTS -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=0.0.0.0:8000,suspend=n -server -Xms2048m -Xmx2048m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=1024m -Dapp.core.home=$CATALINA_HOME/tvs -DIP_DB_PORT=$IP_DB_PORT"

#ADD sample.war /usr/local/tomcat/webapps/
EXPOSE 8080 8787 8443 443 9999 8000

RUN mkdir $CATALINA_HOME/tvs\
    && mkdir /opt/tvs/ \
    && mkdir /opt/tvs/cert  && chmod -R 777 /opt/tvs/
RUN cp -R $CATALINA_HOME/webapps.dist/* $CATALINA_HOME/webapps
CMD chmod -R 777 $CATALINA_HOME/webapps

#ADD conf/* /usr/local/tomcat/conf/
ADD conf/tomcat-users.xml /usr/local/tomcat/conf/
ADD conf/context.xml /usr/local/tomcat/conf/
ADD conf/server.xml /usr/local/tomcat/conf/
ADD conf/application.keystore /usr/local/tomcat/conf/
#ADD lib/ojdbc8.jar /usr/local/tomcat/lib/

RUN cd $CATALINA_HOME/tvs/\
    && mkdir props && chmod -R 777 $CATALINA_HOME/tvs/

COPY tvs-evoting.war $CATALINA_HOME/webapps/
COPY props/* $CATALINA_HOME/tvs/props/
#COPY ../../app/tvs-reception/target/tvs-reception.war  $CATALINA_HOME/webapps/

CMD chmod a+x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]