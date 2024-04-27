# cat Dockerfile
FROM mariadb:10.3

RUN chown -R mysql:root /var/lib/mysql/

ENV MYSQL_DATABASE=CustomerDB
ENV MYSQL_USER=pquijada
ENV MYSQL_PASSWORD=T4c4r1gu4
ENV MYSQL_ROOT_PASSWORD=L4b0n1t4*

ADD script-mariadb/data.sql /etc/mysql/data.sql

RUN sed -i 's/MARIADB_DATABASE/'MARIADB_DATABASE'/g' /etc/mysql/data.sql
RUN cp /etc/mysql/data.sql /docker-entrypoint-initdb.d

EXPOSE 34306