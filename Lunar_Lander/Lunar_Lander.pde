Spaceship s;

StarryBackground background;

void setup(){
  size(700, 700);
  s = new Spaceship();
  background = new StarryBackground(new PVector());
}

void update(){
  s.update();
}

void draw(){
  update();
  
  background(0);
  background.run();
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
