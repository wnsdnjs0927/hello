void setup(){
  size(200, 200); //size of form
}

void draw(){
  background(255); //background color = white
  noStroke(); //border-style = none
  
  fill(255,0,0); //red
  ellipse(20, 20, 16, 16); //position = x:20, y:20, size = width:16, height:16
  
  fill(127, 0, 0); //Dark red
  ellipse(40, 20, 16, 16); //position = x:40, y:20, size = width:16, height:16
  
  fill(255, 200, 200); //Pink
  ellipse(60, 20, 16, 16); //position = x:60, y:20, size = width:16, height:16
}