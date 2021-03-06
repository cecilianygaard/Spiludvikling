/*
OK SO WHAT ARE WE MISSING:
 - Endscreen CHECK
 - Show endscreen at death. CHECK
   - UPDATE TEXT
 - Calculate points
 - Spawn shipfragments at death. CHECK
 - Dust
 - Multiple levels SUPPORT HAS BEEN ADDED NOW ONLY LACKING THE ACTUAL LEVELS
 - New spaceship + shipframents.
 */


int levelI = 0;
int numLevels = 1;
Spaceship s;
Surface surf;
boolean gameStarted = false;
StarryBackground background;
//Ready to be used/spawned at spaceship death
ShipFragments shipDestroyed;

void setup() {
  size(700, 700);
  frameRate(30);
  s = new Spaceship();
  surf = new Surface("data/level"+str(levelI)+".txt");
  background = new StarryBackground(new PVector());
}

void update() {
  s.update();
  surf.collisionSpaceship(s);

  if (s.landed) {
    //WE HAVE TO CALCULATE THE POINTS HERE AS WELL AND RESET TIME AND STUFF
    if (levelI < numLevels-1) {
      print("LEVEL NYT");
      surf = new Surface("data/level"+str(levelI)+".txt");
    } else {
      print("LEVEL NYT");
      levelI = 0;
      surf = new Surface("data/level"+str(levelI)+".txt");
    }
    s.reset();
  }
}

void draw() {
  if (gameStarted && s.alive) {
    update();
    background(0);
    background.run();
    surf.draw();
    s.draw();
    textField();
  } else if (!s.alive) {
    endScreen();
  } else {
    startScreen();
  }
}

//MAKE IT SO THAT THE ROTATION IS CONSTANT AND DOESN'T NEED CONSECUTIVE PRESSES
void keyPressed() {
  if (gameStarted && s.alive) {
    if (key == 'w') {
      s.burnersApplied = true;
    } else if (key == 'd') {
      s.rotatingRight = true;
    } else if (key == 'a') {
      s.rotatingLeft = true;
    }
  }
}

void keyReleased() {
  if (gameStarted && s.alive) {
    if (key == 'w') {
      s.burnersApplied = false;
    } else if (key == 'd') {
      s.rotatingRight = false;
    } else if (key == 'a') {
      s.rotatingLeft = false;
    }
  }
}

void mousePressed() {
  if (mouseX<width/2+50 && mouseX>width/2-50 && mouseY<height/2+20 && mouseY>height/2-20) {
    if (gameStarted && !s.alive) {
      //Restart the game by resetting all the values.
      s = new Spaceship();
    } else {
      gameStarted = true;
    }
  }
}

void textField() {
  push();
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("Score: " + s.score, 20, 50);
  text("Fuel: " + s.fuel, 20, 75);
  text("Time: " + round(frameCount/frameRate), 20, 100);
  text("Altitude: " + round(s.distToSurf), 450, 50);
  text("Horizontal Speed: " + round(s.velocity.x*100), 450, 75); //times 100 so the values aren't crazy small
  text("Vertical Speed: " + round(s.velocity.y*100), 450, 100);
  pop();
}

void startScreen() {
  push();

  background(0);
  background.run();
  surf.draw();
  s.draw();
  textSize(32);
  textAlign(CENTER);
  fill(255);
  text("Lunar Lander", width/2, 100);
  rectMode(CENTER);
  if (mouseX<width/2+50 && mouseX>width/2-50 && mouseY<height/2+20 && mouseY>height/2-20) {
    fill(155);
  }
  rect(width/2, height/2, 100, 40);
  fill(0);
  textSize(15);
  text("Start Game", width/2, height/2+5); 
  pop();
}

//WHEN THE bUTTON IS PRESSED WE SHOULD RESET ALL THE VALUES-
void endScreen() {
  push();
  //CHANGE TEXT AS THIS IS THE ENDSCREEN NOT THE START SCREEN
  background(0);
  background.run();
  surf.draw();
  //s.draw(); INSTEAD OF DRAWING THE SPACESHIP WE SHALL SPAWN AND RUN THE SHIPFRAGMENTS PARTICLESYSTEM
  shipDestroyed.run();
  textSize(32);
  textAlign(CENTER);
  fill(255);
  text("Game Over", width/2, 100);
  textSize(20);
  text("Your total score was: " + s.score, width/2, 150);
  rectMode(CENTER);
  if (mouseX<width/2+50 && mouseX>width/2-50 && mouseY<height/2+20 && mouseY>height/2-20) {
    fill(155);
  }
  rect(width/2, height/2, 100, 40);
  fill(0);
  textSize(15);
  text("Restart", width/2, height/2+5);
  pop();
}
