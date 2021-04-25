# Docker Node Red MQTT
## Instructions
Installer Docker : https://docs.docker.com/desktop/
 
Lancer depuis le terminal : 

    docker-compose -f docker-compose.yml up

Serveur MQTT à : mqtt://localhost:1883
Topic : CapteurCommerce

Le websocket est accessible aux adresses suivantes :
ws://localhost:1880/commerces
ws://localhost:1880/parkings

### A chaque lancement de Docker il faut aller configurer le nom d'utilisateur et le mot de passe dans la node de la base de donnée
 - Aller à http://localhost:1880
 - En haut à droite de l'interface cliquer sur l'engrenage
 - Dans la section "On all flows" selectionner "DB_TER"
 - remplir les champs Username et Password
    - Username : NodeRed 
    - Password : 9a7DkGcPOaW4JsEi
 - Déployer le changement avec le bouton Deploy en haut à droite de l'interface
