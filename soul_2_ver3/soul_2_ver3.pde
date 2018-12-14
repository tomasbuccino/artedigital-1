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
Ani countdown;

AudioPlayer audioactual;
AudioPlayer speechactual;
AudioPlayer negacionactual;
AudioPlayer consentactual;

//-------------- variables de sonido -------------

int aleatorio1;
int aleatorio2;
int aleatorio3;
int aleatorio4;

String audio;
String speech;
String negar;
String aceptar;

//-------------------------------------------------

boolean idle;
boolean triggered;
boolean anicomplete;

String data="" ;
PFont  myFont;  
Boolean sector1 = true;
Boolean sector2 = true;
Boolean sector3 = true;
boolean r = false; 

int diameter = 50;



void setup() {
  
  //always goes first!
  Ani.init(this);
  
  // define a Ani with callbacks, specify the method name after the keywords: onStart, onEnd, onDelayEnd and onUpdate 
  // En esencia los parametros del ani son new ani(target, duracion, el field en string, el valor final de la variable, el easing, el callback)
  countdown = new Ani(this, 5, "diameter", 150, Ani.EXPO_IN_OUT, "onDelayEnd:finalcountdown");  
  
  size(800,700); // size of processing window
  background(0);// setting background color to black
  
  myPort = new Serial(this, "COM6", 9600);
  myPort.bufferUntil('\n');
  minim = new Minim(this);
}

// seteo un reset para que cuando la obra vuelve al sector 3 al alejarse del sensor se reseteen los valores que han sido usados durante la obra

void reset(){
   
  idle = true;
  triggered = true;  //mide si ya se paso o no por el sector 2
  anicomplete = false;  //mide si el countdown se termino
 
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
                
     //se considera sector 1 si entra en estos valores           
     if (value>0 && value<10){
       
         //si es sector1 then...
         if(sector1){            
           println("sector1");
           sector1 = false;
           
            //si el countdown se termino y se respeto, se ejecuta la función question
            
             if(anicomplete){  
               println("bienvenido");
               
               //debería emitir audios en intervalos
               question();
               
               //si el countdown no terminó entonces se ejecuta esta otra función
               }else{  
               println("invasor");
               
               //se pausea el countdown para que no siga dsps de que no haya respetado
               countdown.pause();
               
               //debería emitir audios en intervalos
               denying();  
                    
           }      
         }
         sector2 = true;
         sector3 = true; 
         
    }
     
     //se considera sector 2 si entra en estos valores   
     if (value>20 && value<40){
       
       //si es sector 2 then...
       if(sector2){
         
         //si no se triggereo antes el sector2 then...
         if(triggered){
           
           //se setea un boolean para indicar que ya se activo el sector 2
           triggered = false;
           
           //arranca el countdown
           countdown.start();
           println("sector2");
           sector2 = false;
         }
        }
         sector1 = true;
         sector3 = true;
         
         //pongo un boolean r para indicar que a partir de este momento ya se resetea la obra si el usuario se aleja
         r = true;
     }
     
     //se considera sector 1 si entra en estos valores
     if (value>50){
       
         //si es sector 3 then...
         if(sector3){
           println("sector3");
           sector3 = false;
           
           //debería emitir audios en intervalos
           talking();
         }
         
         sector2 = true;
         sector1 = true;
         
         //si r está registrado then...
         if(r){
           
         //se llama a la función reset 
         reset();
         println ("se resetearon los valores");
         
         }
    }
     
       
  }
}

//----------------------- funciones para randomizar que archivo de sonido se reproduce ------------

void pass(){
   float passing = random(0, 68); //falta cambiar el valor de randoms
   aleatorio4 = floor(passing);
   //println(aleatorio);
   //println("--");
   pasando();
   delay(90);
}  

void denying(){
   float denial = random(0, 68); //falta cambiar el valor de randoms
   aleatorio3 = floor(denial);
   //println(aleatorio);
   //println("--");
   negando();
   delay(90);
}  
  
void talking(){
   float dialogue = random(0, 20); //falta cambiar el valor de randoms
   aleatorio2 = floor(dialogue);
   //println(azar);
   //println("--");
   hablando();
   delay(3000);
}

void question(){
   float numerin = random(0, 68); //falta cambiar el valor de randoms
   aleatorio1 = floor(numerin);
   //println(aleatorio);
   //println("--");
   soundPlay();
   delay(90);
}

//---------------------- funciones de reproducción de archivo sonido -------------------

void pasando(){
   aceptar = "data/voz" + aleatorio4 + ".mp3"; //falta cambiar direccion y nombre de archivos
   println(aceptar);
   consentactual = minim.loadFile(aceptar); 
   consentactual.play();
}

void negando(){
   negar = "data/voz" + aleatorio3 + ".mp3"; //falta cambiar direccion y nombre de archivos
   println(negar);
   negacionactual = minim.loadFile(negar); 
   negacionactual.play();
}

void hablando(){
   speech = "data/voz" + aleatorio2 + ".mp3"; //falta cambiar direccion y nombre de archivos
   println(speech);
   speechactual = minim.loadFile(speech);
   speechactual.play();
}

void soundPlay(){
   audio = "data/voz" + aleatorio1 + ".mp3"; //falta cambiar direccion y nombre de archivos
   println(audio);
   audioactual = minim.loadFile(audio); 
   audioactual.play();
}

//---------------------------------------------------------------------------------------

void serialEvent(Serial myPort) {
 
  data=myPort.readStringUntil('\n');

}

//----------------------------- callback de ani -----------------------------------------

// se llama a esta función OnEnd de countdown
void finalcountdown(Ani) {
  
  //se setea el boolean de que ani ya se completó
  anicomplete = true; //<>//
  
  //se ejecuta un audio que indica que se puede pasar
  pass();
  
  println("termino el countdown");
}