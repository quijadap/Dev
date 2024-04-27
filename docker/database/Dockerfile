FROM  quijadap/oracledatabase:12.2.0.1-se2
# Define variables de entorno
ENV DB_SID=TVS
ENV DB_PDB=CGTS_SECURITY
ENV DB_PASSWD=Sec738

#Define idioma8f499908023a
ENV LC_ALL=es_ES.UTF-8
ENV LANG=es_ES.UTF-8
ENV LANGUAGE=es_ES.UTF-8

ADD importDB.sh /home/oracle/scripts/setup/
ADD 00_DDL_DML_SECURITY.sql /home/oracle/scripts/setup/
#COPY UPDATES_DDL/* /home/oracle/scripts/setup/
USER root
RUN chmod 777 /home/oracle/scripts/setup/importDB.sh \
    && sed -i -e 's/\r$//' /home/oracle/scripts/setup/importDB.sh

USER oracle