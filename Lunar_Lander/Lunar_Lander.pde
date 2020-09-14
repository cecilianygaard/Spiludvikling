Spaceship s;
Surface surf;

void setup(){
  size(700, 700);
  s = new Spaceship();
  surf = new Surface("surface.txt");
}

void update(){
  s.update();
}

void draw(){
  update();
  
  background(0);
  s.draw();
  surf.draw();
}

//MAKE IT SO THAT THE ROTATION IS CONSTANT AND DOESN'T NEED CONSECUTIVE PRESSES
void keyPressed(){
  if(key == 'a'){
    s.rotateLeft();
  }
  else if(key == 'd'){
    s.rotateRight();
  }
}
