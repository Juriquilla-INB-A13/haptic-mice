import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.*;
import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

//connections
int vibr = 3;
int pump = 5;
int pokeL = 8;
int pokeR = 7;
int door = 4;
int inSensor = 2;
int port = 0;
int timeFeed = 5;
int closeAngle = 40;
int openAngle = 90;

//objects
Arduino ardu;

public void setup() {
  ardu = new Arduino(this, Arduino.list()[port], 57600);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(pump, Arduino.PWM);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(pokeL, Arduino.INPUT);
  ardu.pinMode(pokeR, Arduino.INPUT);
  ardu.pinMode(door, Arduino.SERVO);
  ardu.pinMode(inSensor, Arduino.INPUT);
  size(330, 290, JAVA2D);
  createGUI();
  customGUI();
}

public void draw() {
  surface.setTitle("Stage 1 "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  background(230);
}

public void customGUI() {
  fld_freq.setNumericType(G4P.INTEGER);
  fld_repeats.setNumericType(G4P.INTEGER);
  fld_vibr_duration.setNumericType(G4P.DECIMAL);
  fld_response_time.setNumericType(G4P.DECIMAL);
  fld_time_experiments.setNumericType(G4P.DECIMAL);
}

void appendTextToFile(String filename, String text) {
  File f = new File(dataPath(filename));
  if (!f.exists()) {
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

void createFile(File f) {
  File parentDir = f.getParentFile();
  try {
    parentDir.mkdirs(); 
    f.createNewFile();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}   

void fill(int motor)
{
  println("Filling!");
  ardu.digitalWrite(motor, Arduino.HIGH);
  delay(3000);
  ardu.digitalWrite(motor, Arduino.LOW);
  println("Done!");
}

void feed(int motor)
{
  ardu.digitalWrite(motor, Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(motor, Arduino.LOW);
  delay(10);
  ardu.digitalWrite(motor, Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(motor, Arduino.LOW);
}

void vibrate(int ifreq, int iduration)
{
  if (ifreq > 0)
  {
    int off_time, duration;
    off_time = (1000/ifreq);
    duration = (ifreq*iduration)-1;
    for (int i = 0; i <= duration; i++)
    {
      ardu.digitalWrite(3, Arduino.HIGH);
      delay(10);
      ardu.digitalWrite(3, Arduino.LOW);
      delay(off_time);
    }
  } else {
    delay(iduration);
  }
}

boolean checkFields() {
  boolean test;
  if ((fld_freq.getValueI() != 0) || (fld_vibr_duration.getValueI() != 0) || (fld_response_time.getValueI() != 0) || (fld_repeats.getValueI()!=0) || (fld_time_experiments.getValueI() != 0) || (fld_name.getText() != "")) {
    test=true;
  } else {
    println("ERROR: No empty fields allowed! ");
    test=false;
  }
  return test;
}

void openDataFolder() {
  println("Opening folder:"+dataPath(""));
  if (System.getProperty("os.name").toLowerCase().contains("windows")) {
    launch("explorer.exe"+" "+dataPath(""));
  } else {
    launch(dataPath(""));
  }
}
void writeParamsToFile(String flname)
{
  println("FILE:"+flname);
  String datetime = new String(day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  println(datetime);
  String params = new String("freq:" + fld_freq.getValueI()+" time:"+fld_vibr_duration.getValueF()+" response_time:"+fld_response_time.getValueF()+" repeats:"+fld_repeats.getValueI()+" exp_time:"+fld_time_experiments.getValueF());
  println(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}
void writeTableHeader(String flname)
{
  appendTextToFile(flname, "repeat,ellapsed_time,pokeL,pokeR");
}
void writeSeparator(String flname)
{
  appendTextToFile(flname, "");
}

void doExperiment(String flname, int times) {
  if (checkFields()) {
    boolean runLoop;
    String filename = fld_name.getText()+".txt";
    writeParamsToFile(filename);
    writeSeparator(filename);
    writeTableHeader(filename);  
    for (int i=1; i<=times; i++) {
      int timeStart=millis();
      int timeStop=timeStart+int(fld_response_time.getValueF()*1000);
      StringBuilder chain = new StringBuilder(Integer.toString(i));
      runLoop=true;
      while(runLoop){
        if(millis() >= timeStop){
          chain.append(","+float((millis()-timeStart)/1000)+",0,0");
          runLoop=false;
        } else if(ardu.digitalRead(pokeL)==Arduino.HIGH){
          chain.append(","+float((millis()-timeStart)/1000)+",1,0");
          runLoop=false;
        } else if(ardu.digitalRead(pokeR)==Arduino.HIGH){
          chain.append(","+float((millis()-timeStart)/1000)+",0,1");
          runLoop=false;
        }
        
      }
      appendTextToFile(filename,chain.toString());
    }
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    writeSeparator(filename);
    writeSeparator(filename);
  }
}
void closeDoor(){
  for(int i=openAngle;i>closeAngle;i--){
    ardu.servoWrite(door,i);
    delay(5);
  }
}
void openDoor(){
  ardu.servoWrite(door,openAngle);
}