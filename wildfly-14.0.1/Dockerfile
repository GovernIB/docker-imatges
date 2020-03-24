###############################################################################################
# Wildfly 14.0.1 adaptado al entorno de desarrollo del Govern de les Illes Balears (GOIB)
#
# Esta versión comunitaria de Wildfly 14.0.1 corresponde con la versión de Jboss EAP 7.2
# según la web oficial de Redhat https://access.redhat.com/solutions/21906
#
# Comando para construir la imagen: 
# docker build --build-arg KEYCLOAK_URI_ARG=http://keycloak-goib:8180 -t goib/wildfly:14.0.1 .
#
# Comando para crear y ejecutar un contenedor: 
# docker run -p 8080:8080 -p 9990:9990 goib/wildfly:14.0.1
#
# Incluye la mini aplicación /goibusuari que muestra información del usuario autenticado 
# mediante un servidor keycloak que deberá escuchar en la dirección ${KEYCLOAK_URI_ARG}/auth
# y tener configurado el realm GOIB y los clientes goib-default y goib-ws.
#
# Puede utilizarse la siguiente imagen de keycloak:
# docker run -p 8180:8180 goib/keycloak:6.0.1
#
###############################################################################################

FROM jboss/wildfly:14.0.1.Final

LABEL MAINTAINER="Govern de les Illes Balears <suport@caib.es>"

ARG KEYCLOAK_URI_ARG=http://localhost:8180

ENV JBOSS_USER=jboss \
    JBOSS_USER_HOME=/home/${JBOSS_USER} \
    JBOSS_HOME=/opt/jboss/wildfly \
    ADMIN_USER=admin \
    ADMIN_PASSWORD=admin \
    KEYCLOAK_URI=$KEYCLOAK_URI_ARG \
    KEYCLOAK_VERSION=6.0.1 \
    POSTGRESQL_JDBC_VERSION=42.2.5 \
    ORACLE_JDBC_VERSION=12.2.0.1 \
    PATH=${JBOSS_HOME}/bin:/tmp:${PATH}

USER root
WORKDIR /tmp

RUN printenv > env.properties 

USER ${JBOSS_USER}
WORKDIR ${JBOSS_HOME}

#Creación del usuario administrador de JBoss
RUN bin/add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent 

# Drivers de PostgreSQL
RUN curl -OL https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_JDBC_VERSION}.jar
COPY scripts/driver-postgresql-install-offline.cli bin
RUN bin/jboss-cli.sh --file=bin/driver-postgresql-install-offline.cli && \
    rm postgresql-42.2.5.jar && \
    rm bin/driver-postgresql-install-offline.cli

# Drivers de Oracle
RUN curl -OL https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/${ORACLE_JDBC_VERSION}/ojdbc8-${ORACLE_JDBC_VERSION}.jar
COPY scripts/driver-oracle-install-offline.cli bin
RUN bin/jboss-cli.sh --file=bin/driver-oracle-install-offline.cli && \
    rm ojdbc8-${ORACLE_JDBC_VERSION}.jar && \
    rm bin/driver-oracle-install-offline.cli

# Adaptador Wildfly-Keycloak
RUN curl -L https://downloads.jboss.org/keycloak/${KEYCLOAK_VERSION}/adapters/keycloak-oidc/keycloak-wildfly-adapter-dist-${KEYCLOAK_VERSION}.tar.gz | tar zx &&\
    bin/jboss-cli.sh --file=bin/adapter-install-offline.cli
COPY scripts/goibusuari-add-keycloak-offline.cli bin
RUN sed -i "s/<resolve-parameter-values>false<\/resolve-parameter-values>/ <resolve-parameter-values>true<\/resolve-parameter-values>/" bin/jboss-cli.xml &&\ 
    bin/jboss-cli.sh --file=bin/goibusuari-add-keycloak-offline.cli --properties=/tmp/env.properties

RUN rm -rf standalone/configuration/standalone_xml_history/current

COPY files/goibusuari.ear ${JBOSS_HOME}/standalone/deployments/

EXPOSE 8080 8443 9990
ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0"]
