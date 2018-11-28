import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.serial.*;

Serial myPort;
Minim minim;
AudioPlayer audioactual;
AudioPlayer speechactual;

int aleatorio;
int azar;
int rangevalue;
String audio;
String speech;
boolean idle;

String data="";
PFont  myFont;  

void setup() {
  size(800,700); // size of processing window
  background(0);// setting background color to black
  
  myPort = new Serial(this, "COM6", 9600);
  myPort.bufferUntil('\n');
  minim = new Minim(this);
}


void draw() {
  background(0);
  textAlign(CENTER);
  fill(255);
  text(data,820,400);
  textSize(100);
  fill(#4B5DCE);
  text("              Distance :        cm",450,400);
  noFill();
  stroke(#4B5DCE);
  
  
if (data != null && data!="") {
   int value = Integer.parseInt(data.trim());
     
     if (value>60){
       rangevalue = 0;   
     }   
     
     if (value>0 && value<20){
       rangevalue = 1; 
     }
     
     if (value>20 && value<50){
       rangevalue = 2;    
     }

}

switch(rangevalue) {
  case 0: 
    talking();
    println("hablando");
    break;
  case 1: 
    addOne();
    println("sector1");
    break;
  case 2: 
    addOne();
    println("sector2");
    break;

}

}
  
void talking(){
  float dialogue = random(0, 20);
  azar = floor(dialogue);
  //println(azar);
  hablando();
  delay(3000);
}

void hablando(){
  speech = "data/voz" + azar + ".mp3";
  println(speech);
  speechactual = minim.loadFile(speech);
  speechactual.play();
}

void addOne(){
        float numerin = random(0, 68);
        aleatorio = floor(numerin);
        //println(aleatorio);
        //println("--");
        soundPlay();
        delay(90);
}

void soundPlay(){
  audio = "data/voz" + aleatorio + ".mp3";
  println(audio);
  audioactual = minim.loadFile(audio); 
  audioactual.play();
}

void serialEvent(Serial myPort) {
 
  data=myPort.readStringUntil('\n');
}