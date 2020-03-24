# Imatge de Wildfly
Wildfly és la versió comunitaria del servidor d'aplicacions Jboss EAP. Segons la [Web oficial de Redhat] (https://access.redhat.com/solutions/21906), aquesta versió 14.0.1 correspon a la versión Jboss EAP 7.2. 

La imatge docker proveeix un servidor d'aplicacions Wildfly adaptat a l'entorn de desenvolupament del GOIB. En concret, la imatge inclou: drivers d'Oracle; drivers de PostgreSQL; connector Wildfly-Keycloak; i la mini aplicació goibusuari.  

## Creació i execució d'un contenidor  
```$ docker run -p 8080:8080 -p 9990:9990 -d goib/wildfly:14.0.1``` 

## Administració
L'usuari administrador per defecte és admin (password admin). Es pot personalitzar executant:  
```$ docker run -p 8080:8080 -p 9990:9990 -d -e ADMIN_USER=user -e ADMIN_PASSWORD=password goib/wildfly:14.0.1``` 

## Aplicació goibusuari de prova
Aquesta imatge inclou la mini aplicació /goibusuari que mostra informació de l'usuari autenticat mitjançant un servidor Keycloak que haurà d'escoltar peticions des de l'adreça http://keycloak-goib:8180/auth i tenir configurat el realm GOIB i els clients goib-default i goib-ws. Per connectar aquesta imatge de Wildfly amb Keycloak es pot fer servir la imatge Keycloak del GOIB. Per això, és necessari afegir l'adreça **127.0.0.1 keycloak-goib** al fitxer de hosts (en Unix/Linux /etc/hosts; en Windows C:\Windows\System32\drivers\etc\hosts) i executar el següent fitxer docker-compose.xml.

```  
version: '3.6'

services:
 keycloak:
    image: goib/keycloak:6.0.1
    container_name: "keycloak-goib"   
    environment:
     - KEYCLOAK_USER=admin
     - KEYCLOAK_PASSWORD=admin
    ports:
     - 8180:8180
    healthcheck:
      test: ["CMD", "curl", "-f", "http://keycloak-goib:8180/auth/realms/GOIB"]
      interval: 10s
      timeout: 10s
      retries: 5
 wildfly:
    image: goib/wildfly:14.0.1
    container_name: "wildfly-goib"
    environment:
     - ADMIN_USER=admin
     - ADMIN_PASSWORD=admin
    ports:
     - 8080:8080
     - 9990:9990
    depends_on:
      - keycloak
``` 
 
Per iniciar els serveis: 
```$ docker-compose up -d``` 
 
Per aturar els serveis: 
```$ docker-compose down``` 

