void setup(){
  size(200, 200); //size of form
}

void draw(){
  background(255); //background color = white
  fill(0); //alpha = 0%
  text("Hello Strings!", 10, 100); //text position = x:10 y:100
  fill(255/2); //alpha = 50%
  text("Hello Strings!", 10, 150); //text position = x:10 y:150
}