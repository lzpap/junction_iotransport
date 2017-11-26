/* How to use the DHT-22 sensor with Arduino uno
   Temperature and humidity sensor
   More info: http://www.ardumotive.com/how-to-use-dht-22-sensor-en.html
   Dev: Michalis Vasilakis // Date: 1/7/2015 // www.ardumotive.com */

//Libraries
#include <DHT.h>;
#include "CurieIMU.h"
#include <SoftwareSerial.h>
boolean blinkState = false;   // state of the LED


//Constants
#define DHTPIN 13     // what pin we're connected to
#define DHTTYPE DHT22   // DHT 22  (AM2302)
DHT dht(DHTPIN, DHTTYPE); //// Initialize DHT sensor for normal 16mhz Arduino
SoftwareSerial bluettooth(1,0);


//Variables
int chk;
float hum;  //Stores humidity value
float temp; //Stores temperature value
float smart_contract_value; //dynamically changing value of a smart contract
float coeff=0.1; //degradation coefficient

void setup()
{
    Serial.begin(9600);// wait for serial port to connect..
     while(!Serial) ;
    /* Initialise the IMU */
    CurieIMU.begin();
    CurieIMU.attachInterrupt(eventCallback);

    /* Enable Shock Detection */
    CurieIMU.setDetectionThreshold(CURIE_IMU_SHOCK,1500); // 1.5g = 1500 mg
    CurieIMU.setDetectionDuration(CURIE_IMU_SHOCK, 50);   // 50ms
    CurieIMU.interrupts(CURIE_IMU_SHOCK);
    Serial.println("IMU initialisation complete, waiting for events...");
    dht.begin();
    smart_contract_value=2000.0;
    Serial.println("Value of smart contract: 2000 $");

}

void loop()
{
    //Read data and store it to variables hum and temp
    hum = dht.readHumidity();
    temp= dht.readTemperature();
    if (hum >70 || hum<20)
      smart_contract_value-=3;
    else
      smart_contract_value+=0.1;
    if (temp >25 || temp<20)
      smart_contract_value-=3;
    else
      smart_contract_value+=0.1;
    if (smart_contract_value<1500.0)
      smart_contract_value=1500.0;
    if (smart_contract_value > 3000.0) smart_contract_value=1000.0;
    //Print temp and humidity values to serial monitor
    Serial.print("Sensor:");
    Serial.print(",");
    Serial.print(hum);
    Serial.print(",");
    Serial.print(temp);
    //Serial.print(" Celsius");
    Serial.print(",");
    Serial.println(smart_contract_value);
    delay(2000); //Delay 2 sec.
}
static void eventCallback(void)
{
  int ax,ay,az;
  CurieIMU.readAccelerometer(ax,ay,az);
  float gx,gy,gz;
  int range=CurieIMU.getAccelerometerRange();
  gx = (ax/32768.0)*range;
   gy = (ay/32768.0)*range;
    gz = (az/32768.0)*range;
  if (CurieIMU.getInterruptStatus(CURIE_IMU_SHOCK)) {
    if (CurieIMU.shockDetected(X_AXIS, POSITIVE))
    {
      smart_contract_value-= abs(gx)*0.5;
      Serial.print("Shock:");
      Serial.print(",");
      Serial.print("-x");
      Serial.print(",");
      Serial.print(gx);
      Serial.print(",");
      Serial.println(smart_contract_value);
    }
    if (CurieIMU.shockDetected(X_AXIS, NEGATIVE))
     {
      smart_contract_value-= abs(gx)*coeff;
      Serial.print("Shock:");
      Serial.print(",");
      Serial.print("+x");
      Serial.print(",");
      Serial.print(gx);
      Serial.print(",");
      Serial.println(smart_contract_value);
 
    } 
    if (CurieIMU.shockDetected(Y_AXIS, POSITIVE))
    {
      smart_contract_value-= abs(gy)*coeff;
      Serial.print("Shock:");
      Serial.print(",");
      Serial.print("-y");
      Serial.print(",");
      Serial.print(gy);
      Serial.print(",");
      Serial.println(smart_contract_value);
    }

    if (CurieIMU.shockDetected(Y_AXIS, NEGATIVE))
        {
      smart_contract_value-= abs(gy)*coeff;
      Serial.print("Shock:");
      Serial.print(",");
      Serial.print("+y");
      Serial.print(",");
      Serial.print(gy);
      Serial.print(",");
      Serial.println(smart_contract_value);
        }
    if (CurieIMU.shockDetected(Z_AXIS, POSITIVE))
        {
      smart_contract_value-= abs(gz)*coeff;
      Serial.print("Shock:");
      Serial.print(",");
      Serial.print("-z");
      Serial.print(",");
      Serial.print(gz);
      Serial.print(",");
      Serial.println(smart_contract_value);
    }
    if (CurieIMU.shockDetected(Z_AXIS, NEGATIVE))
      {
      smart_contract_value-= abs(gz)*coeff;
      Serial.print("Shock:");
      Serial.print(",");
      Serial.print("+z");
      Serial.print(",");
      Serial.print(gz);
      Serial.print(",");
      Serial.println(smart_contract_value);
      }
  }
 }


   
