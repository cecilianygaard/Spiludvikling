Spaceship s;
boolean gameStarted = false;
StarryBackground background;
//Ready to be used/spawned at spaceship death
//ShipFragments shipDestroyed;

void setup() {
  size(700, 700);
  s = new Spaceship();
  background = new StarryBackground(new PVector());
}

void update() {
  s.update();
}

void draw() {
  if (gameStarted) {
    update();

    background(0);
    background.run();
    s.draw();
    if (!keyPressed) {
      s.burnersApplied = false;
    }
    textField();
  } else {
    startScreen();
  }
}

//MAKE IT SO THAT THE ROTATION IS CONSTANT AND DOESN'T NEED CONSECUTIVE PRESSES
void keyPressed() {
  if (gameStarted) {
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
}

void mousePressed() {
  if(mouseX<width/2+50 && mouseX>width/2-50 && mouseY<height/2+20 && mouseY>height/2-20) {
    gameStarted = true;
  }
}

void textField() {
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("Score: " + s.score, 20, 50);
  text("Fuel: " + s.fuel, 20, 75);
  text("Time: " + round(frameCount/frameRate), 20, 100);
  text("Altitude: " + round(height-s.location.y), 450, 50); //NEEDS TO BE CHANGED TO DISTANCE TO GROUND AND NOT BOTTOM OF SCREEN
  text("Horizontal Speed: " + round(s.velocity.x*100), 450, 75); //times 100 so the values aren't crazy small
  text("Vertical Speed: " + round(s.velocity.y*100), 450, 100);
}

void startScreen() {
 background(0);
    background.run();
    s.draw();
    textSize(32);
    textAlign(CENTER);
    text("Lunar Lander", width/2, 100);
    fill(255);
    rectMode(CENTER);
      if(mouseX<width/2+50 && mouseX>width/2-50 && mouseY<height/2+20 && mouseY>height/2-20) {
        fill(155);
      }
    rect(width/2, height/2, 100, 40);
    fill(0);
    textSize(15);
    text("Start Game", width/2, height/2+5); 
}
