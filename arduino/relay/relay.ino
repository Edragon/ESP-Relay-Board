
#include <FS.h>                   //this needs to be first, or it all crashes and burns...

#include <ESP8266WiFi.h>          //https://github.com/esp8266/Arduino
//needed for library
#include <DNSServer.h>
#include <ESP8266WebServer.h>
#include <WiFiManager_custom.h>          //https://github.com/tzapu/WiFiManager
#include <ArduinoJson.h>          //https://github.com/bblanchon/ArduinoJson
#include <PubSubClient.h>
#include <String.h>
#include <Ticker.h>

//flag for saving data
bool shouldSaveConfig = false;

//define your default values here, if there are different values in config.json, they are overwritten.
//char mqtt_server[40];
#define mqtt_server       "139.59.102.70"
#define mqtt_port         "1883"
#define mqtt_user         "ed"
#define mqtt_pass         "dragon"
#define humidity_topic    "sensor/humidity"

#define suffix          "cmd"

// mqtt
WiFiClient espClient;
PubSubClient client(espClient);
Ticker flipper;

long lastMsg = 0;
float temp = 0.0;
float hum = 0.0;
float diff = 1.0;

String key_mac;

char my_device[24];
char devic_prefix[6] = "ESP_";

int relay1 = 4;
int relay2 = 5;
int statusLED = 16;

void loop() {
  digitalWrite(statusLED, HIGH);
  delay(1000);
  digitalWrite(statusLED, LOW);
  delay(1000);

  // put your main code here, to run repeatedly:
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  long now = millis();
  if (now - lastMsg > 1000) {
    lastMsg = now;

    // humidity
    float newTemp = 10;
    float newHum = 20;

    if (checkBound(newHum, hum, diff)) {
      hum = newHum;
      Serial.print("(Not yet working) New humidity:");
      Serial.println(String(hum).c_str());
      client.publish(humidity_topic, String(hum).c_str(), true);
    }
  }
}
