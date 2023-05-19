#!/bin/bash
echo ">>>>  Right before SG initialization <<<<"
/opt/jboss/keycloak/bin/jboss-cli.sh -c "module add --name=es.caib.autenticacio.afirma --resources=/tmp/es.caib.afirmaauth.jar --dependencies=org.keycloak.keycloak-core,org.keycloak.keycloak-server-spi,org.keycloak.keycloak-server-spi-private,org.keycloak.keycloak-services,org.jboss.logging,org.jboss.ws.api,org.jboss.resteasy.resteasy-jaxrs,javax.ws.rs.api,javax.jws.api,javax.xml.ws.api,javax.servlet.api"
/opt/jboss/keycloak/bin/jboss-cli.sh -c "deployment deploy-file /tmp/es.caib.afirmaauth.jar"
#while true
#do
#    netstat -uplnt | grep :9990 | grep LISTEN > /dev/null
#    verifier=$?
#    if [ 0 = $verifier ]
#        then
           echo "Running search guard plugin initialization"           
#           sleep 60
#           /opt/jboss/keycloak/bin/jboss-cli.sh -c "deployment deploy-file /tmp/es.caib.afirmaauth.jar"
 #           break
 #       else
            echo "ES is runned"
 #           sleep 5
 #   fi
#done
