void highInterrupt() {
  WiFiManager wifiManager;
  wifiManager.resetSettings();
  ESP.eraseConfig();
  ESP.reset();
}


void espRST() {

  attachInterrupt(0, highInterrupt, FALLING);
}

int relay_test = 0;

void flip()
{
  digitalWrite(4,HIGH);
  digitalWrite(5,HIGH);
  digitalWrite(16,HIGH);
  delay(1000);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(16, LOW);
  delay(1000);  
  ++count;

  if (relay_test == 2)
  {
    flipper.detach();
  }
}


