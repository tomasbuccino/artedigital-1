import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.serial.*;
import processing.serial.*;

//variable para el mapeo
String data="" ;
int SensorValue = 0;

// Nombro los sectores
String sector1 = "sector1";
String sector2 = "sector2";
String sector3 = "sector3";

// Flags para saber en qué sector está el user
Boolean isSector1 = false;
Boolean isSector2 = false;
Boolean isSector3 = false;

/* 
Seteo las distancias de los sectores 
Si el sector va de 0 a 60, uso el valor 60.
Si el sector va de 60 a 100, uso el valor 100.
*/
int sector1Distance = 30;
int sector2Distance = 80;
int sector3Distance = 180;

// Un hack para saber si está o no sonando un audio
Boolean isPlayingSound = false;

//Serial myport
Serial myPort;

// Minim
Minim minim;
AudioPlayer audioPlayer;

// Ani
Ani diameterAni;
int diameter = 50;
// Hack porque cuando inicializamos Ani, ejecuta el callback.
Boolean aniFirstTime = true;
Boolean isAniCompleted = false;

void setup() {
    size(800,600);
    
    Ani.init(this);
    
    
    myPort = new Serial(this, "COM6", 9600);
    myPort.bufferUntil('\n');
    
    minim = new Minim(this);
     
     diameterAni = new Ani(this, 1.5, 1, "diameter", 150, Ani.EXPO_IN_OUT, "onDelayEnd:delayIsOver"); 
}

void draw() {
    
  // Hack para saber si está o no sonando un audio.
  if (audioPlayer != null) {
    if (audioPlayer.isPlaying()) {
      isPlayingSound = true;
    } else {
      isPlayingSound = false;
    }
  }
   
        
  if (data != null && data!="") {
  SensorValue = Integer.parseInt(data.trim());
  println(SensorValue);
  
  }
    
    
} 

// Cuando registra el sensor sale esta func
void Sensorama(int SensorValue) {
  // println(checkSector(sliderValue));
  manageSectorActions(checkSector(SensorValue));
}

// Dependiendo el valor del sensor, devuelve el sector
String checkSector(int SensorValue) {
    resetSectors();
    if (SensorValue <= sector1Distance) {
      println("sector1");
      isSector1 = true;
      return sector1;
    }
    if (SensorValue > sector1Distance && SensorValue <= sector2Distance) {
      println("sector2");
      isSector2 = true;
      return sector2;
    }
    if (SensorValue > sector2Distance) {
      println("sector3");
      isSector3 = true;
      return sector3;
    }
    return "none";
}

void resetSectors() {
  println("se resetearon los valores");
  isSector1 = false;
  isSector2 = false;
  isSector3 = false;
}

// Reproduce sonidos aleatorios siempre y cuando no esté sonando otro.

void soundPlay(int random) {
  String audio;
  audio = "data/voz" + random + ".mp3";
  if (!isPlayingSound) {
    println(audio);
    audioPlayer = minim.loadFile(audio);
    audioPlayer.play();
  }
}

void manageSectorActions(String sector) {
  // println(sector);
  int random = 0;
  switch (sector) {
    case "sector1":
     if (isAniCompleted) {
        random = floor(random(0,10));
      } else {
        random = floor(random(10,20));
      }
      soundPlay(random);
    break;
    
    case "sector2":
      soundPlay(2);
      diameterAni.start();
    break;
    
    case "sector3":
      random = floor(random(20,30));
      soundPlay(random);
      isAniCompleted = false;
    break;
  } 
}

void delayIsOver() {
  if (!aniFirstTime) {
    println("Pass");
    // Hardcodeo el audio que dice "Oh, we understand";
    soundPlay(3);
    isAniCompleted = true;
  }

  aniFirstTime = false;
}


void serialEvent(Serial myPort) {
 
  data=myPort.readStringUntil('\n');

}