import processing.serial.*;

Serial myPort; 
String portName;
String stringRecvFromArduino;
String keyDisp;
float val1, val2, val3, val4;
float[] keep_val1;
float[] keep_val2;
float[] keep_val3;
int nSample = 200;

void setup() {
  
  size(800, 600);
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  //myPort = new Serial(this, Serial.list()[0], 9600);
  
  int portnum = Serial.list().length - 1;
  myPort = new Serial(this, Serial.list()[portnum], 38400);
  portName = Serial.list()[portnum];
    
  keep_val1 = new float[nSample];
  keep_val2 = new float[nSample];
  keep_val3 = new float[nSample];
  val1 = 0;
  stringRecvFromArduino="";
  keyDisp = "-";
}


void draw() {
  background(255);  
  fill(0);   
  int lf = 10;    // Linefeed in ASCII
  String buf;
  buf = String.format("%s", portName); 
  text(buf, 20,30);
  
  buf = String.format("%06d, %.0f", frameCount, val1);
  text(buf, 20,50);
  
  text("Sent: " + keyDisp, 20,70);
  
  text("Spring Constant : " + val4 + "\n(100~600)", 20,90);
  
  text("Sensor values"+"\n"+val1, 20,220);
  String value = String.format("%.2f", val2/200);
  text("Position, xh"+"\n"+value+"cm", 20,340);
  text("Force"+"\n"+val3/1000, 20,440);

  // Draw graph - raw sensor values
  int offset_x1 = 100;
  int offset_y1 = 250;
  int y1=0, y2;
  float g = 0.05;
  float gx = 2.0;
  for(int i=0; i<nSample-1; i++)
  {
    y1 = int(offset_y1 - g* keep_val1[i]) - 0;
    y2 = int(offset_y1 - g* keep_val1[i+1]) - 0;
    stroke(255,0,0);
    line(offset_x1 + gx*i, y1, offset_x1 + gx*(i+1), y2);
    
    stroke(0,255,0);
    y1 = int(offset_y1 - g* keep_val2[i]) + 100;
    y2 = int(offset_y1 - g* keep_val2[i+1]) + 100;
    line(offset_x1 + gx*i, y1, offset_x1 + gx*(i+1), y2);
    
    stroke(0,0,255);
    y1 = int(offset_y1 - g* keep_val3[i]) + 200;
    y2 = int(offset_y1 - g* keep_val3[i+1]) + 200;
    line(offset_x1 + gx*i, y1, offset_x1 + gx*(i+1), y2);
  }
  
  // Draw graph - Position : xh
  offset_x1 = 100;
  offset_y1 = 350;
  g = 3000.0;


  // Draw graph - Force
  offset_x1 = 100;
  offset_y1 = 450;
  g = 100.0;  


  // Receiving from Arduino
  while (myPort.available() > 0) 
  {
    String str1  = myPort.readStringUntil(lf);//myPort.readString();
    stringRecvFromArduino = str1;
    if (str1 != null) 
    {
      String[] str_split = str1.split(",");
      if(str_split.length >2)
      {
        val1 = float(str_split[0]);
        ShiftWithNewf(keep_val1, val1);
        
        val2 = float(str_split[1]) * 20000;
        ShiftWithNewf(keep_val2, val2);
        
        val3 = float(str_split[2]) * 1000;
        ShiftWithNewf(keep_val3, val3);
        
        val4 = float(str_split[3]);
      }
    }
  }
}

void keyPressed() {
    keyDisp = String.format("%c", key);
    myPort.write(key);
}

//////////////////////////////////////////////////////////////////////////
// Do not change from this line !

public static void ShiftWithNewf(float[] arr, float n_val)
{
  int sz = arr.length;
  int i;
  for(i=0; i< sz-1; i++)
  {
  arr[sz-1-i] = arr[sz-2-i];
  
  }

  arr[0] = n_val;

}