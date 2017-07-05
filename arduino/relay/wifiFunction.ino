


String getMAC() {
  String keyMac;

  String macID = WiFi.macAddress();
  Serial.println("your mac address is:" + macID);
  keyMac += macID.substring(9, 11);
  keyMac += macID.substring(12, 14);
  keyMac += macID.substring(15, 17);
  Serial.println("and your key mac is:" + keyMac);

  return keyMac;
}


//callback notifying us of the need to save config
void saveConfigCallback () {
  Serial.println("Should save config");
  shouldSaveConfig = true;
}



void callback(char* topic, byte* payload, unsigned int length) {
  String str_content = "";
  String str_topic = "";
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");

  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
    str_content += (char)payload[i];
  }
  Serial.println();

  str_topic = String((char*)topic);
  String my_str_device = String((char*)my_device);
  
  // useless topic check
  if ( str_topic == my_str_device) {
    Serial.println("Topic catch");
    if (str_content == "rest") {
      Serial.println("reset  ..");
    }
    else if (str_content == "1_ON") {
      Serial.println("Relay 1 ON ..");
      digitalWrite(relay1, HIGH);
    }
    else if (str_content == "1_OFF") {
      Serial.println("Relay 1 OFF ..");
      digitalWrite(relay1, LOW);
    }

    else if (str_content == "2_ON") {
      Serial.println("Relay 2 ON ..");
      digitalWrite(relay2, HIGH);
    }
    else if (str_content == "2_OFF") {
      Serial.println("Relay 2 OFF ..");
      digitalWrite(relay2, LOW);
    }
  } else {
    Serial.println("wrong topic");
  }
}


void reconnect() {

  // Loop until we're reconnected mqtt
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    // If you do not want to use a username and password, change next line to
    if (client.connect(my_device)) {
      Serial.println("connected");

      client.publish("devices", my_device);

      // ... and resubscribe
      client.subscribe(my_device);

    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}
