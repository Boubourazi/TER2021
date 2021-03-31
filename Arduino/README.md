# Arduino

## Instructions

### Installation et configuration de l'IDE

Installer Arduino IDE : https://www.arduino.cc/en/software
Installer le driver CP210X : https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers

Sur Arduino IDE, et cliquez sur "Fichier" puis "Préférences". Dans le champ "URL de gestionnaire de cartes supplémentaires", entrez : https://dl.espressif.com/dl/package_esp32_index.json, http://arduino.esp8266.com/stable/package_esp8266com_index.json

Quittez la fenêtre, cliquez sur "Outils" puis "Gérer les bibliothèques", et installez la bibliothèque "PubSubClient".
Toujours dans "Outils", choisissez le type de carte "DOIT ESP32 DEVKIT V1", et le port "COM4".

### Branchements et configuration de l'Arduino

Munissez vous de votre ESP32, de votre PIR Motion sensor ainsi que de 3 câbles.
Sur le capteur, repérez la pin GND, et branchez la à la pin GND de l'ESP32.
Sur le capteur, repérez la pin OUT ou DATA, et branchez la à la pin 22 de l'ESP32.
Sur le capteur, repérez la pin VCC, et branchez la à la pin 3V3 de l'ESP32, ou d'une autre source d'énergie.

![Branchements](https://techtutorialsx.com/wp-content/uploads/2018/07/esp32-pir-diagram.png)

Vous pouvez maintenant relier par USB votre Arduino à votre ordinateur.

### Téléverser le code

Ouvrez le programme programSujet.ino, puis cliquez en haut à gauche sur le bouton "Téléverser". 
Une fois le programme sur l'ESP32, ouvrez le moniteur série en haut à droite, puis choisissez dans la liste déroulante en bas 115200 bauds.

Vous devriez pouvoir passer votre main devant le capteur, et voir apparaître le message "Mouvement détecté" 