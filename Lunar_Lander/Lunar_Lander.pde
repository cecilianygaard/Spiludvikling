Spaceship s;

StarryBackground background;
//Ready to be used/spawned at spaceship death
//ShipFragments shipDestroyed;

void setup(){
  size(700, 700);
  s = new Spaceship();
  background = new StarryBackground(new PVector());
}

void update() {
  s.update();
}

void draw() {
  update();

  background(0);
  background.run();
  s.draw();
  if(!keyPressed) {
    s.burnersApplied = false;
  }
}

//MAKE IT SO THAT THE ROTATION IS CONSTANT AND DOESN'T NEED CONSECUTIVE PRESSES
void keyPressed() {
  if (key == 'w') {
    s.applyBurners();
  } else if (key == 'd') {
    s.rotateRight();
    s.burnersApplied = false;
  } else if (key == 'a') {
    s.rotateLeft();
    s.burnersApplied = false;
  }
}
