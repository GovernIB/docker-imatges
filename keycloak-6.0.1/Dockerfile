#############################################################################################
# Keycloak 6.0.1 adaptado al entorno de desarrollo del Govern de les Illes Balears (GOIB)
#
# Comando para construir la imagen: 
# docker build -t goib/keycloak:6.0.1 .
#
# Comando para crear y ejecutar un contenedor: 
# docker run -p 8180:8180 --name NOMBRE_CONTENEDOR goib/keycloak:6.0.1
#
# Incluye: realm GOIB; clients goib-default, goib-ws y goib-cert; rol EBO_SUPERVISOR a nivel
# de realm y clients; usuario para autenticarse u999000 con password u999000;
# y usuario de aplicación $GOIB_USUARI con password $GOIB_USUARI
#
#############################################################################################

FROM jboss/keycloak:6.0.1

LABEL MAINTAINER="Govern de les Illes Balears <suport@caib.es>"
ENV KEYCLOAK_USER=admin \
    KEYCLOAK_PASSWORD=admin \
    KEYCLOAK_IMPORT=/tmp/import-goib-realm.json

WORKDIR /opt/jboss/

COPY scripts/import-goib-realm.json /tmp

USER jboss

EXPOSE 8180

CMD ["-b 0.0.0.0 -bmanagement 0.0.0.0 -Djboss.socket.binding.port-offset=100"]
