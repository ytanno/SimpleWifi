const int LedPin = 13;
bool Switch = false;
void setup() 
{
  Serial.begin(9600);
  pinMode(LedPin, OUTPUT);
}

void loop()
{
      if(Serial.available()>0)
      {
        char c = Serial.read();
        if(c == '1') Switch = true;
        if(c == '0') Switch = false;
      }
      if(Switch) digitalWrite(LedPin, HIGH);
      else digitalWrite(LedPin, LOW);
      delay(50);         
}
