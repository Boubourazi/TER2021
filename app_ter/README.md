# Application mobile

Application permettant de visualiser les données dans le but du projet TER2021 en Master TI 

## Informations sur l'application 

L’application à été développée en langage Dart grâce au kit de développement logiciel Flutter, qui permet un développement transplateforme sur Windows, Mac, Linux, Android, iOS, Google Fuchsia et version web.

## Description

Depuis le menu de l'application, il suffit de choisir le type de données qui nous intéresse en bas de l’écran afin d’afficher celle-ci sur la carte ( Commerces, Parkings, Bus, Qualité de l’air). À son lancement, l’application récupère toutes les données dont elle a besoin depuis le Node-Red via une requête HTTP, puis elles sont mises à jour en temps réel à chaque événement (entrée / magasin d’un magasin / parking, bus qui se déplace) via WebSocket entre le Node-Red et l’application.
