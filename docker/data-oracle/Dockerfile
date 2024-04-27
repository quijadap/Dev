FROM quijadap/oracledb:12.2.0.1-se2

MAINTAINER jpacheco@autentia.com

ADD ddl.sql /ddl.sql

ENV ORACLE_HOME=/u01/app/oracle/product/12.2.0.1-se2xe

ENV SQLPLUS=$ORACLE_HOME/bin/sqlplus

RUN service oracle-xe start;$SQLPLUS system/oracle@xe @ddl.sql; echo 'BBDD formación ready ...'