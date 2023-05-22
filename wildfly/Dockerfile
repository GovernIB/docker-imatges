#FROM jboss/wildfly:14.0.1.Final
FROM jboss/base-jdk:11

LABEL MAINTAINER="Govern de les Illes Balears <suport@caib.es>"

ARG KEYCLOAK_URI_ARG=http://keycloak-goib:8180

ENV JBOSS_USER=jboss \
    JBOSS_USER_HOME=/home/${JBOSS_USER} \
    JBOSS_HOME=/opt/jboss/wildfly \
    ADMIN_USER=admin \
    ADMIN_PASSWORD=admin \
    KEYCLOAK_URI=$KEYCLOAK_URI_ARG \
    KEYCLOAK_VERSION=6.0.1 \
    POSTGRESQL_JDBC_VERSION=42.2.5 \
    ORACLE_JDBC_VERSION=12.2.0.1 \
    PATH=${JBOSS_HOME}/bin:/tmp:${PATH} \
    WILDFLY_VERSION=14.0.0.Final

USER root
RUN yum -y install wget

RUN cd $HOME
RUN wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.zip
RUN sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

WORKDIR /tmp

RUN printenv > env.properties 

USER ${JBOSS_USER}
WORKDIR ${JBOSS_HOME}

#Creación del usuario administrador de JBoss
RUN bin/add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent 

# Drivers de PostgreSQL
#RUN curl -OL https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_JDBC_VERSION}.jar
COPY bin/postgresql-${POSTGRESQL_JDBC_VERSION}.jar $HOME
COPY scripts/driver-postgresql-install-offline.cli bin
RUN bin/jboss-cli.sh --file=bin/driver-postgresql-install-offline.cli && \
    rm postgresql-42.2.5.jar && \
    rm bin/driver-postgresql-install-offline.cli

# Oracle drivers
#RUN curl -OL https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/${ORACLE_JDBC_VERSION}/ojdbc8-${ORACLE_JDBC_VERSION}.jar
COPY bin/ojdbc8-${ORACLE_JDBC_VERSION}.jar $HOME
COPY scripts/driver-oracle-install-offline.cli bin
RUN bin/jboss-cli.sh --file=bin/driver-oracle-install-offline.cli 
#    rm ojdbc8-${ORACLE_JDBC_VERSION}.jar && \
#    rm bin/driver-oracle-install-offline.cli

# Wildfly-Keycloak connector
#RUN curl -L https://downloads.jboss.org/keycloak/${KEYCLOAK_VERSION}/adapters/keycloak-oidc/keycloak-wildfly-adapter-dist-${KEYCLOAK_VERSION}.tar.gz | tar zx &&\
COPY bin/keycloak-wildfly-adapter-dist-${KEYCLOAK_VERSION}.tar.gz $HOME
#    bin/jboss-cli.sh --file=bin/adapter-install-offline.cli
RUN tar xf keycloak-wildfly-adapter-dist-${KEYCLOAK_VERSION}.tar.gz && bin/jboss-cli.sh --file=bin/adapter-install-offline.cli


RUN rm -rf standalone/configuration/standalone_xml_history/current


EXPOSE 8080 8443 9990
ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0"]
