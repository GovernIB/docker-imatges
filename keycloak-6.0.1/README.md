# Imatge de keycloak
Keycloak és un producte de programari de codi obert que permet l'inici de sessió únic (IdP) amb Identity Management i Access Management. La imatge docker proveeix un servidor de keycloak adaptat a l'entorn de desenvolupament del GOIB. En concret, la imatge inclou: el realm GOIB; els clients goib-default, goib-ws i goib-cert; el rol EBO_SUPERVISOR a nivell de realm i clients; l'usuari u999000 (password u999000) al client goib-default; i l'usuari d'aplicació $GOIB_USUARI (password $GOIB_USUARI) al client goib-ws.  

## Construcció de la imatge  
    $ docker build -t goib/keycloak:6.0.1 .  
  
## Creació i execució d'un contenidor  
    $ docker run -p 8180:8180 --name NOMBRE_CONTENEDOR goib/keycloak:6.0.1  

