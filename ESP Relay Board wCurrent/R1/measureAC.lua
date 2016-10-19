const int sensorIn = A0;
int mVperAmp = 185; -- use 100 for 20A Module and 66 for 30A Module


Voltage = 0;
VRMS = 0;
AmpsRMS = 0;


 Voltage = getVPP();
 VRMS = (Voltage/2.0) *0.707; 
 AmpsRMS = (VRMS * 1000)/mVperAmp;
 print(AmpsRMS.. "AmpsRMS")

}

function getVPP()
    

float getVPP()
{
  float result;
  
  int readValue;             --value read from the sensor
  int maxValue = 0;          -- store max value here
  int minValue = 1024;          -- store min value here
  
   uint32_t start_time = millis();
   while((millis()-start_time) < 1000) //sample for 1 Sec
   {
       readValue = analogRead(sensorIn);
       -- see if you have a new maxValue
       if (readValue > maxValue) 
       {
           /*record the maximum sensor value*/
           maxValue = readValue;
       }
       if (readValue < minValue) 
       {
           /*record the maximum sensor value*/
           minValue = readValue;
       }
   }
   
   // Subtract min from max
   result = ((maxValue - minValue) * 5.0)/1024.0;
      
   return result;
 }