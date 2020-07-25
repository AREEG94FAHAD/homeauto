#include <SoftwareSerial.h>
#include <Servo.h>
   Servo myservo; // create servo object to control a servo
   int potpin = 9; // analog pin used to connect the potentiometer
   int val; // variable to read the value from the analog pin

SoftwareSerial hc06(2,3);
int led = 12;//of room
int led2 = 7;// of alert
int pinofmotion = 8; //of motion

void setup(){
  //Initialize Serial Monitor
  Serial.begin(9600);
  Serial.println("ENTER AT Commands:");
  pinMode(led,OUTPUT);
   pinMode(led2,OUTPUT);
  pinMode(pinofmotion, INPUT);
   myservo.attach(9); // attaches the servo on pin 9 to the servo object
  //Initialize Bluetooth Serial Port
  hc06.begin(9600);
}

void loop(){
  
   if(digitalRead(pinofmotion)==HIGH){
    digitalWrite(led2,HIGH);
    Serial.println("Movement detected.");
   }else{
    digitalWrite(led2,LOW);
   }

   
  //Write data from HC06 to Serial Monitor
  if (hc06.available()){
 
    char C = hc06.read();
    
   if(C=='o'){Serial.write(C); digitalWrite(led,HIGH);}
    
   if(C=='f'){digitalWrite(led,LOW);}

  if(C=='m'){
   val = analogRead(potpin);
   // reads the value of the potentiometer (value between 0 and 1023)
   val = map(1023, 0, 1023, 0, 180);
   // scale it to use it with the servo (value between 0 and 180)
   myservo.write(val); // sets the servo position according to the scaled value
  }
  if(C=='b'){
   val = analogRead(potpin);
   // reads the value of the potentiometer (value between 0 and 1023)
   val = map(0, 0, 1023, 0, 180);
   // scale it to use it with the servo (value between 0 and 180)
   myservo.write(val); // sets the servo position according to the scaled value
  }
  }
  
  //Write from Serial Monitor to HC06
//  if (Serial.available()){
//    hc06.write(Serial.read());
//  }  
}