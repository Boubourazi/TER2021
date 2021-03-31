#include <WiFi.h>
#include <PubSubClient.h>

////////////////////////////////////////////////////////////////////////////

//Sensor consts
#define sensorID "1_in"
#define sensorType "in"
//#define sensorType "out"

//Wifi variables
const char* ssid       = "Bbox-CBC47700";
const char* password   = "n2GJvaqSMhrh4M137h";

//pin of the PIR motion sensor
int PIR_data = 22;

//MQTT Broker IP address
const char* mqtt_server = "192.168.1.19";

//MQTT variables
WiFiClient espClient;
PubSubClient client(espClient);

////////////////////////////////////////////////////////////////////////////

void callback(char* topic, byte *payload, unsigned int length) {
  Serial.print("Message arrived on topic : ");
  Serial.print(topic);
  Serial.print("data:");
  Serial.write(payload, length);
  Serial.println();
}

////////////////////////////////////////////////////////////////////////////

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    if (client.connect("ESP32Board")) {
      Serial.println("connected");
    } else {
      Serial.print(" failed, error code : ");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

////////////////////////////////////////////////////////////////////////////

void setup_wifi() {

  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }

  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.print("IP address : ");
  Serial.println(WiFi.localIP());
}

////////////////////////////////////////////////////////////////////////////

void setup()
{
  Serial.begin(115200);
  pinMode (PIR_data, INPUT);

  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
}

////////////////////////////////////////////////////////////////////////////

void loop()
{
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  int val = digitalRead(PIR_data);

  if (val == HIGH) {
    Serial.println("Mouvement détecté");
    client.publish("CapteurParking", "{\"sensorId\":\"" sensorID "\",\"type\":\"" sensorType "\"}");
  }
  delay(3000);
}
