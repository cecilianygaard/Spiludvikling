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
  textField();
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

void textField() {
  fill(255);
  textSize(20);
  text("Score: " + s.score, 20,50);
  text("Fuel: " + s.fuel,20,75);
  text("Time: " + round(frameCount/frameRate), 20,100);
  text("Altitude: " + round(height-s.location.y), 450,50); //NEEDS TO BE CHANGED TO DISTANCE TO GROUND AND NOT BOTTOM OF SCREEN
  text("Horizontal Speed: " + round(s.velocity.x*100), 450, 75); //times 100 so the values aren't crazy small
  text("Vertical Speed: " + round(s.velocity.y*100), 450, 100);
}
