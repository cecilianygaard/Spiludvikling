//This is just the blueprint for the spaceship class DONE
class Spaceship {
  boolean alive = true;
  boolean landed = false;

  float w = 20;
  float h = 20;
  
  float score;
  //We are basically using a mover-class here, though as it is the only object with this functionality we will just implement it directly
  //ALSO REMEMBER: COMPOSITION OVER INHERITANCE
  PVector location;
  PVector velocity;
  PVector acceleration;

  //The angle of the rotation of the spaceship (in radians)
  float angle;

  //YEAH THIS SHOULD ALSO BE CALLIBRATED
  float burnerPower = -0.01;
  //I HAVE CHANGED THE VALUE FOR DEVELOPMENT PURPOSES
  float fuel = 2000;

  //DIST TO SURFACE WILL BE UPDATED BY SURFACE'S COLLISION METHOD.
  float distToSurf = 0;

  //Controls
  boolean burnersApplied = false;
  boolean rotatingRight = false;
  boolean rotatingLeft = false;
  
  float cell = w/5;
  PVector[][] spaceShapes = { //Main body
                           {new PVector(-0.5*cell, 0.5*cell), 
                            new PVector(0.5*cell, 0.5*cell), 
                            new PVector(1.5*cell, -0.5*cell), 
                            new PVector(1.5*cell, -1.5*cell), 
                            new PVector(0.5*cell, -2.5*cell), 
                            new PVector(-0.5*cell, -2.5*cell), 
                            new PVector(-1.5*cell, -1.5*cell), 
                            new PVector(-1.5*cell, -0.5*cell), 
                            new PVector(-0.5*cell, 0.5*cell)}, 
                            //Burner
                           {new PVector(-0.5*cell, 0.5*cell), 
                            new PVector(0.5*cell, 0.5*cell), 
                            new PVector(1*cell, 2.5*cell), 
                            new PVector(-1*cell, 2.5*cell), 
                            new PVector(-0.5*cell, 0.5*cell)},
                            //Left leg
                           {new PVector(-0.5*cell, 0.5*cell), 
                            new PVector(-2*cell, 2.5*cell),
                            new PVector(-2.5*cell, 2.5*cell),
                            new PVector(-1.5*cell, 2.5*cell)},
                            //Right leg
                           {new PVector(0.5*cell, 0.5*cell), 
                            new PVector(2*cell, 2.5*cell),
                            new PVector(2.5*cell, 2.5*cell),
                            new PVector(1.5*cell, 2.5*cell)}};

  Spaceship() {
    location = new PVector(0, height/5);
    velocity = new PVector(0.7, 0.02);
    acceleration = new PVector(0, 0);
  }

  void rotateLeft() {
    angle -= 0.05;
  }

  void rotateRight() {
    angle += 0.05;
  }

  void applyGravity() { 
    PVector gravity = new PVector(0, 0.0005);
    //!!!!!
    acceleration.add(gravity);
  }

  void applyBurners() {
    if (fuel>0) {

      float x = burnerPower * cos(angle+PI/2); //Changes from polar to cartesian
      float y = burnerPower * sin(angle+PI/2); //Changes from polar to cartesian
      PVector burnerForce = new PVector(x, y);

      acceleration.add(burnerForce);
      fuel--;
      burnersApplied = true;
    } else {
      burnersApplied = false;
    }
  }

  void reset() {
    timeTakenLevel = millis()/1000;
    location = new PVector(0, height/5);
    velocity = new PVector(0.7, 0.02);
    landed = false;
  }

  void update() {
    if (!landed && alive) {
      //Controls that control rotation and stuff
      if (burnersApplied) {
        this.applyBurners();
      }
      if (rotatingLeft) {
        this.rotateLeft();
      }
      if (rotatingRight) {
        this.rotateRight();
      }

      //Gravity will always be applied.
      this.applyGravity();
      //Standard mechanics, thanks NEWTON
      velocity.add(acceleration);
      location.add(velocity);
      //We clear the acceleration
      acceleration.mult(0);
    } else if (!alive) {
      println("AHH U DIED");
    } else if (landed) {
      println("WUHUUU YOU LANDED SUCCESSFULLY");
    }
  }

  void givePoints(LandingPlatform platform) {
    score += 500*platform.point/(millis()/1000-timeTakenLevel);
  }

  void draw() {
    //The spaceship will be some certain width and height.
    push();
    //We translate to the center of the space ship
    translate(location.x, location.y);
    // We rotate the given angle
    rotate(angle);
    //DRAWING THE SHAPE
    stroke(255);
    fill(0);
    for (int i = 0; i < spaceShapes.length; i++) {
      beginShape();
      for (int ii = 0; ii < spaceShapes[i].length-1; ii++) {
        vertex(spaceShapes[i][ii].x, spaceShapes[i][ii].y);
        vertex(spaceShapes[i][ii+1].x, spaceShapes[i][ii+1].y);
      }
      endShape();
    }
    stroke(0,0);
    if (burnersApplied) {
      if (frameCount%8>4) {
        fill(255, 0, 0);
        triangle(cell, h/2, -cell, h/2, 0, h/2+25);
        fill(255, 128, 0);
        triangle(cell-cell/5, h/2, -cell+cell/5, h/2, 0, h/2+15);
        fill(255, 255, 0);
        triangle(cell-cell/4, h/2, -cell+cell/4, h/2, 0, h/2+7.5);
      } else {
        fill(255, 0, 0);
        triangle(cell, h/2, -cell, h/2, 0, h/2+20);
        fill(255, 128, 0);
        triangle(cell-cell/5, h/2, -cell+cell/5, h/2, 0, h/2+10);
        fill(255, 255, 0);
        triangle(cell-cell/4, h/2, -cell+cell/4, h/2, 0, h/2+5);
      }
    }
    pop();
  }
}
