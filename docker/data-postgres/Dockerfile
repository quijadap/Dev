# Init Example Database World on PostgreSQL
ARG POSTGRES_TAG=15.2
FROM postgres:$POSTGRES_TAG

ENV POSTGRES_USER world
ENV POSTGRES_PASSWORD world123
ENV POSTGRES_DB world-db

# Copier les scripts SQL dans : 
ADD script-postgres/*.sql /docker-entrypoint-initdb.d/

