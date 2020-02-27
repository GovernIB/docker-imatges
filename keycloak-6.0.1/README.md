# Imatge de keycloak

Per a construir la imatge:  
$ docker build -t goib/keycloak:6.0.1 .  
Per a crear i executar un contenidor:  
$ docker run -p 8180:8180 --name NOMBRE_CONTENEDOR goib/keycloak:6.0.1  
  
Inclou: realm GOIB; clients goib-default, goib-ws i goib-cert; rol EBO_SUPERVISOR a nivell de realm i clients; usuari per autenticar-se u999000 amb password u999000;  i usuari d'aplicació $GOIB_USUARI amb password $GOIB_USUARI
