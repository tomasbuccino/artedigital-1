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
boolean limite = false;
boolean alone = true;
String audio;
String speech;

String data="" ;
PFont  myFont;  
Boolean sector1 = true;
Boolean sector2 = true;

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
  
  //talking();
  
  
  if (data != null && data!="") {
        int value = Integer.parseInt(data.trim());
        
     if (value>0 && value<30){
         if(sector1){
           println("sector1");
           sector1 = false;
           addOne();
         }
         sector2 = true;
         
    }
     
     if (value>30 && value<80){
       if(sector2){
           println("sector2");
           sector2 = false;
           //speechactual.pause();
           addOne();
         }
         sector1 = true;
     }
       
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