import processing.serial.*;
Serial myPort;


float hum,temp,dir, magn, value;  //variables to read from serial port message
int xPos=0; //current x position on screen
float valueMagn,valueTemp,valueHum,valueCont; //scaled values from variable 
float [][] dataArray; //array to hold recent values
int xmax=1500;
int ymax=1000;
int margin=45;
int arraysize=(xmax/2-2*margin);

void setup() {
  size(1500, 1000);
   myPort = new Serial(this, Serial.list()[0], 9600); 
   myPort.bufferUntil('\n');
   valueMagn=0.0;
   valueTemp=0.0;
   valueHum=0.0;
   valueCont=0.0;
   hum=0.0;
   temp=0.0;
   dir=0.0;
   magn=0.0;
   value=0.0;
   background(0);
   dataArray=new float[arraysize][4];
   for (int i=0;i<arraysize;i++)
   {
     for (int j=0; j<4; j++)
     {
       dataArray[i][j]=0.0;
     }
   }
   
   
}

void draw() {

    if (xPos<arraysize) //still filling the screen with data
      {
        background(0);
        fill(255);
        rect(xmax/2, ymax/2, xmax, ymax);
        textSize(26);
        textAlign(CENTER);
        fill(255);
        text(("Shock detection"),xmax/4,margin);
        text(magn+("g"),xmax/4,1.7*margin);
        text(("Humidity"),3*xmax/4,margin);
        text(hum+("%"),3*xmax/4,1.7*margin);
        text(("Temperature"),xmax/4,ymax/2+margin);
        text(temp+("°C"),xmax/4,ymax/2+1.7*margin);
        fill(0);
        text(("Smart Contract Value"),3*xmax/4,ymax/2+margin);
        text(value+("$"),3*xmax/4,ymax/2+1.7*margin);
        stroke(255,255,255);
        line(xmax/2, 0, xmax/2, ymax); //split the screen into different windows
        line(0, ymax/2, xmax, ymax/2);
        for (int i=0; i<7; i++)
        {
          stroke(255);
          line(margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6, xmax/2-margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6);
          line(xmax/2+margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6, xmax-margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6);
          line(margin, ymax-margin-i*(ymax/2-3.7*margin)/6, xmax/2-margin, ymax-margin-i*(ymax/2-3.7*margin)/6);
          stroke(0);
          line(xmax/2+margin, ymax-margin-i*(ymax/2-3.7*margin)/6, xmax-margin, ymax-margin-i*(ymax/2-3.7*margin)/6);
        }
        stroke(255);
        line(margin, 2.7*margin, margin, ymax/2-margin);
        line(xmax/2-margin, 2.7*margin, xmax/2-margin, ymax/2-margin);
        
        line(margin, ymax/2+2.7*margin, margin, ymax-margin);
        line(xmax/2-margin, ymax/2+2.7*margin, xmax/2-margin, ymax-margin);
        
        line(xmax/2+margin, 2.7*margin, xmax/2+margin, ymax/2-margin);
        line(xmax-margin, 2.7*margin, xmax-margin, ymax/2-margin);
        
        stroke(0);
        
        line(xmax/2+margin, ymax/2+2.7*margin,xmax/2+margin, ymax-margin);
        line(xmax-margin, ymax/2+2.7*margin, xmax-margin, ymax-margin);
        
        dataArray[xPos][0]=valueMagn; //filling that array
        dataArray[xPos][1]=valueHum;
        dataArray[xPos][2]=valueTemp;
        dataArray[xPos][3]=valueCont;
        for (int i=0; i<(xPos+1); i++)
        { //drawing the lines already in the array
        stroke(255,255,0);
         line(i+margin, ymax/2-margin, i+margin, ymax/2-margin-dataArray[i][0]); //<>//
    
         stroke(102,102,255);
         line(i+xmax/2+margin,ymax/2-margin, i+xmax/2+margin, ymax/2-margin-dataArray[i][1]);
    
         stroke(255,51,255);
         line(i+margin, ymax-margin, i+margin, ymax-margin-dataArray[i][2]);
    
         stroke(0,255,0);
         line(i+xmax/2+margin, ymax-margin, i+xmax/2+margin, ymax-margin-dataArray[i][3]);
        }

       xPos++; //next position
      }
    else //array is full, from now on shifting elemnents to the right
    {
     background(0);
        fill(255);
        rect(xmax/2, ymax/2, xmax, ymax);
        textSize(26);
        textAlign(CENTER);
        fill(255);
        text(("Shock detection"),xmax/4,margin);
        text(magn+("g"),xmax/4,1.7*margin);
        text(("Humidity"),3*xmax/4,margin);
        text(hum+("%"),3*xmax/4,1.7*margin);
        text(("Temperature"),xmax/4,ymax/2+margin);
        text(temp+("°C"),xmax/4,ymax/2+1.7*margin);
        fill(0);
        text(("Smart Contract Value"),3*xmax/4,ymax/2+margin);
        text(value+("$"),3*xmax/4,ymax/2+1.7*margin);
        stroke(255,255,255);
        line(xmax/2, 0, xmax/2, ymax); //split the screen into different windows
        line(0, ymax/2, xmax, ymax/2);
        for (int i=0; i<7; i++)
        {
          stroke(255);
          line(margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6, xmax/2-margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6);
          line(xmax/2+margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6, xmax-margin, ymax/2-margin-i*(ymax/2-3.7*margin)/6);
          line(margin, ymax-margin-i*(ymax/2-3.7*margin)/6, xmax/2-margin, ymax-margin-i*(ymax/2-3.7*margin)/6);
          stroke(0);
          line(xmax/2+margin, ymax-margin-i*(ymax/2-3.7*margin)/6, xmax-margin, ymax-margin-i*(ymax/2-3.7*margin)/6);
        }
        stroke(255);
        line(margin, 2.7*margin, margin, ymax/2-margin);
        line(xmax/2-margin, 2.7*margin, xmax/2-margin, ymax/2-margin);
        
        line(margin, ymax/2+2.7*margin, margin, ymax-margin);
        line(xmax/2-margin, ymax/2+2.7*margin, xmax/2-margin, ymax-margin);
        
        line(xmax/2+margin, 2.7*margin, xmax/2+margin, ymax/2-margin);
        line(xmax-margin, 2.7*margin, xmax-margin, ymax/2-margin);
        
        stroke(0);
        
        line(xmax/2+margin, ymax/2+2.7*margin,xmax/2+margin, ymax-margin);
        line(xmax-margin, ymax/2+2.7*margin, xmax-margin, ymax-margin);
      for (int i=0; i<(xPos-1); i++)
      {  
        dataArray[i][0]=dataArray[i+1][0]; //shifting (optimization -> use fifo =queue structure, this is not efficient)
        dataArray[i][1]=dataArray[i+1][1];
        dataArray[i][2]=dataArray[i+1][2];
        dataArray[i][3]=dataArray[i+1][3];
          stroke(255,255,0);
         line(i+margin, ymax/2-margin, i+margin, ymax/2-margin-dataArray[i][0]);
    
         stroke(102,102,255);
         line(i+xmax/2+margin,ymax/2-margin, i+xmax/2+margin, ymax/2-margin-dataArray[i][1]);
    
         stroke(255,51,255);
         line(i+margin, ymax-margin, i+margin, ymax-margin-dataArray[i][2]);
    
         stroke(0,255,0);
         line(i+xmax/2+margin, ymax-margin, i+xmax/2+margin, ymax-margin-dataArray[i][3]);
        
      }
      dataArray[xPos-1][0]=valueMagn;
      dataArray[xPos-1][1]=valueHum;
      dataArray[xPos-1][2]=valueTemp;
      dataArray[xPos-1][3]=valueCont;
       stroke(255,255,0);
         line(xPos+margin, ymax/2-margin, xPos+margin, ymax/2-margin-dataArray[xPos-1][0]);
    
         stroke(102,102,255);
         line(xPos+xmax/2+margin,ymax/2-margin, xPos+xmax/2+margin, ymax/2-margin-dataArray[xPos-1][1]);
    
         stroke(255,51,255);
         line(xPos+margin, ymax-margin, xPos+margin, ymax-margin-dataArray[xPos-1][2]);
    
         stroke(0,255,0);
         line(xPos+xmax/2+margin, ymax-margin, xPos+xmax/2+margin, ymax-margin-dataArray[xPos-1][3]);
    }

     // xPos=0;
     // background(0);

    delay(10);
    }
  /*serialEvent(myPort);
  background(51); 
      stroke(127,34,255);
    line(xPos, height, xPos, height-valuey);
    if(xPos >=width) {
      xPos=0;
      background(0);
     }
    else{xPos++;}
  
  // Cycle through the array, using a different entry on each frame. 
  // Using modulo (%) like this is faster than moving all the values over.
  */
void serialEvent(Serial myPort)
{
  int newLine = 13; // new line character in ASCII
  String message;

  //do {
    message = myPort.readStringUntil(newLine); // read from port until new line
    if (message != null) {
      String[] list = split(trim(message), ",");
      if (list.length >= 4 && list[0].equals("Sensor:")) {
        hum= float(list[1]); 
        temp = float(list[2]); 
        value = float(list[3]); 

      }
      if (list.length >=4 && list[0].equals("Shock:")) {
        dir = float(list[1]); 
        magn = abs(float(list[2])); 
        value = float(list[3]); 
        valueMagn=map(magn,0,3,0, ymax/2-3.7*margin);
      } else { valueMagn=0;magn=0;}
       
       valueHum=map(hum,0,100,0, ymax/2-3.7*margin);
       if (temp!=0.0)
       valueTemp=map(temp,20,50,0, ymax/2-3.7*margin);
       if (temp>50.0) valueTemp=ymax/2-3.7*margin;
       if (value!=0.0)
       valueCont=map(value,1500,2500,0,ymax/2-3.7*margin);
       if (valueCont>3000.0) valueCont=3000;
    
  
  }}