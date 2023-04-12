#include <Servo.h> 

// Defines Tirg y Echo del Ultrasonic Sensor
const int trigPin = 10;
const int echoPin = 11;

// Variables para la duración y distancia
long duration;
int distance;

Servo myServo; // Creas una variable servo
int buzzerPin = 8; // Define el pin de salida del buzzer

void setup() {
  pinMode(trigPin, OUTPUT); // Sets el trigPin como un Output
  pinMode(echoPin, INPUT); // Sets el echoPin como un Input
  pinMode(buzzerPin, OUTPUT); // Sets el pin del buzzer como un Output
  Serial.begin(9600); 
  myServo.attach(12); // Defines los pines del servo
}

void loop() {
  // rotacion del servo de  15 a 165 grados
  for(int i=15;i<=165;i++){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();// calcular distancia
  
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
    
    if(distance < 30){ // si detecta un objeto cercano
      tone(buzzerPin, 1500); // encender la bocina
      delay(500); // esperar medio segundo
    }
    else {
      noTone(buzzerPin); // apagar la bocina
    }
  }

  // repetición
  for(int i=165;i>15;i--){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
    
    if(distance < 30){ // si detecta un objeto cercano
      tone(buzzerPin, 1500); // encender la bocina
      delay(500); // esperar un segundo
    }
    else {
      noTone(buzzerPin); // apagar la bocina
    }
  }
}

// calcular distancia
int calculateDistance(){ 
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH); // leer el echoPin, retorna la honda ultrasónica
  distance= duration*0.034/2;
  return distance;
}
