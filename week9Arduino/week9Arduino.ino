  
int cnt1 = 0;
void setup() {
  Serial.begin(9600);
}


void loop() {
  char buf[255];
  sprintf(buf, "%d", cnt1);
 
  
  Serial.println(buf);
  cnt1++;
  //각 초마다1씩증가
  delay(1000);
}

