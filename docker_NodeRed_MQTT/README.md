# Docker Node Red MQTT
## Instructions
Installer Docker : https://docs.docker.com/desktop/
 
Lancer depuis le terminal : 

    docker-compose -f docker-compose.yml up

serveur mqtt à : mqtt://localhost:1883
topic : CapteurCommerce

websockets accessibles aux adresses
ws://localhost:1880/commerces
ws://localhost:1880/parkings

### A chaque lancement de Docker il faut aller configurer le nom d'utilisateur et le mot de passe dans la node de la base de donnée
 - Aller a http://localhost:1880
 - En haut à droite de l'interface cliquer sur l'engrenage
 - Dans la section "On all flows" selectionner "DB_TER"
 - remplir les champs Username et Password
    - Username : NodeRed 
    - Password : 9a7DkGcPOaW4JsEi
 - Deployer le changement avec le bouton Deploy en haut à droite de l'interface
