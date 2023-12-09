# cat Dockerfile
FROM mysql:latest

RUN chown -R mysql:root /var/lib/mysql/

ENV MYSQL_DATABASE=samplesDocker
ENV MYSQL_USER=pquijada
ENV MYSQL_PASSWORD=T4c4r1gu4
ENV MYSQL_ROOT_PASSWORD=L4b0n1t4*

ADD script-mysql/data.sql /etc/mysql/data.sql

RUN sed -i 's/MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /etc/mysql/data.sql
RUN cp /etc/mysql/data.sql /docker-entrypoint-initdb.d

EXPOSE 3306