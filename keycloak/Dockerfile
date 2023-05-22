#############################################################################################
# Keycloak 6.0.1 adaptado al entorno de desarrollo del Govern de les Illes Balears (GOIB)
#
# Comando para construir la imagen: 
# docker build -t goib/keycloak:6.0.1 .
#
# Comando para crear y ejecutar un contenedor: 
# docker run -p 8180:8180 goib/keycloak:6.0.1
#
# Expone el puerto 8180
#
# Incluye: el realm GOIB; los clientes goib-default y goib-ws; el rol EBO_SUPERVISOR a nivel
# de realm y clientes; el usuario u999000 con password u999000 para autenticación goib-default;
# y el usuario $GOIB_USUARI con password $GOIB_USUARI para autenticación goib-ws
#
#############################################################################################

FROM jboss/keycloak:6.0.1

#ENV http_proxy http://10.215.2.65:3128
#ENV https_proxy http://10.215.2.65:3128

LABEL MAINTAINER="Govern de les Illes Balears <suport@caib.es>"
ENV KEYCLOAK_USER=admin \
    KEYCLOAK_PASSWORD=admin \
    KEYCLOAK_IMPORT=/tmp/import-goib-realm.json

WORKDIR /opt/jboss/

#RUN apt-get -y update && apt-get install -y net-tools

#RUN apt install -y net-tools

COPY scripts/import-goib-realm.json /tmp
COPY module.xml /tmp
#COPY es.caib.afirmaauth.jar /tmp
COPY scripts/add_plugin.sh /opt/jboss/startup-scripts/add_plugin.sh
COPY standalone.xml /opt/jboss/keycloak/standalone/configuration/standalone.xml
#RUN chmod +x /tmp/add_plugin.sh

#COPY es /opt/jboss/modules/system/layers/keycloak/

#RUN bash /tmp/add_plugin.sh

USER jboss

EXPOSE 8080
#-Djboss.socket.binding.port-offset=100"
CMD ["-b 0.0.0.0 -bmanagement 0.0.0.0"]
