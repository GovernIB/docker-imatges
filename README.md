# docker-imatges
L'objectiu del projecte **docker-imatges** és proporcionar l’entorn de desenvolupament necessari als desenvolupadors per fer servir els [estàndards de desenvolupament](https://www.caib.es/sites/dgtic/ca/estandards_de_desenvolupament/) del Govern de les Illes Balears sense necessitat d'instal·lar cada component per separat. Per aixó, s'han definit vàries imatges Docker personalitzades de diferents components i un fitxer docker-compose.yml per orquestar-les.

Les imatges utlizades són:
1. Servidor d'aplicacions Wildfly (versió comunitaria del servidor d'aplicacions Jboss EAP).
2. Servidor d'autenticació Keycloak.
3. Servidor de base de dades PostgreSQL.
4. Pgadmin com a eina gràfica de gestió de base de dades.

Trobareu aquestes imatges i el docker-compose.yml  a la branca [docker-imatges-1.0](https://github.com/GovernIB/docker-imatges/tree/docker-imatges-1.0).
