  
void setup() 
{
  size(640, 360);
}

void draw() //loop
{
  background(102);
  pushMatrix();
    translate(width*0.5, height*0.5);
    rotate(frameCount / 200.0); //20sec = 1 rotate
    polygon(0, 0, 82, 3);  // Triangle(3)
  popMatrix();
}


void polygon(float x, float y, float radius, int npoints)
{
  float angle = TWO_PI / npoints; 
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) 
  {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}