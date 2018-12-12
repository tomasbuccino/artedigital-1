import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.serial.*;
import de.looksgood.ani.*;

Serial myPort;
Minim minim;
AudioPlayer audioactual;
AudioPlayer speechactual;

int aleatorio;
int azar;
boolean limite = false;
boolean alone = true;
boolean idle;
boolean triggered;
boolean anicomplete;
String audio;
String speech;

String data="" ;
PFont  myFont;  
Boolean sector1 = true;
Boolean sector2 = true;
Boolean sector3 = true;
boolean r = false; 

int diameter = 50;

Ani countdown;

void setup() {
  size(800,700); // size of processing window
  background(0);// setting background color to black
  
  Ani.init(this);
  
  // define a Ani with callbacks, specify the method name after the keywords: onStart, onEnd, onDelayEnd and onUpdate 
  countdown = new Ani(this, 5, "diameter", 150, Ani.EXPO_IN_OUT, "onDelayEnd:finalcountdown");  
  
  
  myPort = new Serial(this, "COM6", 9600);
  myPort.bufferUntil('\n');
  minim = new Minim(this);
}

void reset(){
   
  idle = true;
  triggered = true;
  anicomplete = true;
 
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
                
     if (value>0 && value<30){
         if(sector1){
           println("sector1");
           sector1 = false;
             if(anicomplete){
               println("ywelcome");
               question();
               
             }else{
               println("trespasser");
               countdown.pause();
               denying();
                    
           }      
         }
         sector2 = true;
         sector3 = true; 
         
    }
     
     if (value>30 && value<80){
       if(sector2){
         if(triggered){
           triggered = false;
           countdown.start();
           println("sector2");
           sector2 = false;
         }
        }
         sector1 = true;
         sector3 = true;
         r = true;
     }
     
     if (value>90){
         if(sector3){
           println("sector3");
           sector3 = false;
           talking();
         }
         
         sector2 = true;
         sector1 = true;
         
         if(r){
           
         reset();
         
         }
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

void denying(){
        float numerin = random(0, 68);
        aleatorio = floor(numerin);
        //println(aleatorio);
        //println("--");
        soundPlay();
        delay(90);
}

void question(){
        float numerin = random(0, 68);
        aleatorio = floor(numerin);
        //println(aleatorio);
        //println("--");
        soundPlay();
        delay(90);
}

void pass(){
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

// called onEnd of diameterAni animation
void finalcountdown(Ani theAni) {
  anicomplete = false; //<>//
  pass();
  println("ani is done");
}