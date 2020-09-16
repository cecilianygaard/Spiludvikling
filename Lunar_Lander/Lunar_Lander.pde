int levelI = 0;
int numLevels = 1;
int distToSurfZoom = 200;
int timeTakenLevel = 0;
boolean gameStarted = false;

Spaceship s;
Surface surf;
StarryBackground background;
ShipFragments shipDestroyed;
Camera closeCam;
DustyLanding dustCloud;

void setup() {
  size(700, 700);
  frameRate(30);
  s = new Spaceship();
  surf = new Surface("data/level"+str(levelI)+".txt");
  background = new StarryBackground(new PVector());
  dustCloud = new DustyLanding();
  closeCam = new Camera();
}

void update() {
  s.update();
  surf.collisionSpaceship(s);
  if (s.distToSurf <= distToSurfZoom) {
    closeCam.update(s);
    if (s.burnersApplied) {
      dustCloud.updateOrigin(s.location.x, s.location.y+s.distToSurf);
      for (int i = 0; i < int(distToSurfZoom/s.distToSurf); i++) {
        dustCloud.addParticle();
      }
    }
  }

  if (s.landed) {
    //WE HAVE TO CALCULATE THE POINTS HERE AS WELL AND RESET TIME AND STUFF
    if (levelI < numLevels-1) {
      surf = new Surface("data/level"+str(levelI)+".txt");
    } else {
      levelI = 0;
      surf = new Surface("data/level"+str(levelI)+".txt");
    }
    s.reset();
    dustCloud = new DustyLanding();
  }
}

void draw() {
  if (gameStarted && s.alive) {
    update();
    push();
    if (s.distToSurf <= distToSurfZoom) {
      scale(closeCam.zoom);
      translate(-closeCam.transX, -closeCam.transY);
    }
    background(0);
    background.run();
    surf.draw();
    dustCloud.run();
    s.draw();
    pop();
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
    if (key == 'w' || keyCode == UP) {
      s.burnersApplied = true;
    } else if (key == 'd' || keyCode == RIGHT) {
      s.rotatingRight = true;
    } else if (key == 'a' || keyCode == LEFT) {
      s.rotatingLeft = true;
    }
  }
}

void keyReleased() {
  if (gameStarted && s.alive) {
    if (key == 'w' || keyCode == UP) {
      s.burnersApplied = false;
    } else if (key == 'd' || keyCode == RIGHT) {
      s.rotatingRight = false;
    } else if (key == 'a' || keyCode == LEFT) {
      s.rotatingLeft = false;
    }
  }
}

void mousePressed() {

  if (mouseX<width/2+50 && mouseX>width/2-50 && mouseY<height/2+20 && mouseY>height/2-20) {
    if (gameStarted && !s.alive) {
      //Restart the game by resetting all the values.
      s = new Spaceship();
      dustCloud = new DustyLanding();
      timeTakenLevel = millis()/1000;
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
  text("Score: " + round(s.score), 20, 50);
  text("Fuel: " + round(s.fuel), 20, 75);
  text("Time: " + round(millis()/1000-timeTakenLevel), 20, 100);
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
