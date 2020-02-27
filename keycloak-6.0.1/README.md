# Imatge de Keycloak / Imagen de Keycloak
Keycloak és un producte de programari de codi obert que permet l'inici de sessió únic (IdP) amb Identity Management i Access Management. La imatge docker proveeix un servidor de keycloak adaptat a l'entorn de desenvolupament del GOIB. En concret, la imatge inclou: el realm GOIB; els clients goib-default, goib-ws i goib-cert; el rol EBO_SUPERVISOR a nivell de realm i clients; l'usuari u999000 (password u999000) en el client goib-default; i l'usuari d'aplicació $GOIB_USUARI (password $GOIB_USUARI) en el client goib-ws.  

Keycloak es un producto de software de código abierto que permite el inicio de sesión único (IdP) con Identity Management y Access Management. La imagen docker provee un servidor de keycloak adaptado al entorno de desarrollo del GOIB. En concreto, la imagen incluye: el realm GOIB; los clientes goib-default, goib-ws y goib-cert; el rol EBO_SUPERVISOR a nivel de realm y clientes; el usuario u999000 (password u999000) en el cliente goib-default; y el usuario de aplicación $GOIB_USUARI (password $GOIB_USUARI) en el cliente goib-ws.  
  
## Creació i execució d'un contenidor / Creación y ejecución de un contenedor 
    $ docker run -p 8180:8180 goib/keycloak:6.0.1  

L'usuari administrador per defecte és admin/admin. Es pot personalitzar executant:  
El usuario administrador por defecto es admin/ admin. Se puede personalizar ejecutando el comando:  
    $ docker run -p 8180:8180 -e KEYCLOAK_USER=user -e KEYCLOAK_PASSWORD=password goib/keycloak:6.0.1

