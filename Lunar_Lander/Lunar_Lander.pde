Spaceship s;

void setup(){
  size(500, 500);
  s = new Spaceship();
}

void update(){
  s.update();
}

void draw(){
  update();
  
  background(0);
  s.draw();
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
