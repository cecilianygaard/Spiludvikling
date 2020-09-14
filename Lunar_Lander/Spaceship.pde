//This is just the blueprint for the spaceship class DONE
class Spaceship{
  float w = 20;
  float h = 20;
  PImage img;
  
  //We are basically using a mover-class here, though as it is the only object with this functionality we will just implement it directly
  //ALSO REMEMBER: COMPOSITION OVER INHERITANCE
  PVector location;
  PVector velocity;
  PVector acceleration;

  //The angle of the rotation of the spaceship (in radians)
  float angle;

  //YEAH THIS SHOULD ALSO BE CALLIBRATED
  float burnerPower = -0.01;
  float fuel = 200;
  boolean burnersApplied = false;
  //WHAT SHALL BE INITIALIZED?

  Spaceship(){
    location = new PVector(width/2,0);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    img = loadImage("Spaceship.png");
  }

  void rotateLeft() {
    angle -= 0.05;
  }

  void rotateRight() {
    angle += 0.05;
  }

  void applyGravity() { 
    //!!!! THIS SHOULD DEFINITELY NOT BE A MEMBERVARIABLE!!!! AS WE SHOULD USE THE SAME GRAVITY FOR THE PARTICLES OR?
    //WHAT SHOULD GRAVITY BE?
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



  void update() {
    //Gravity will always be applied.
    this.applyGravity();
    //Standard mechanics, thanks NEWTON
    velocity.add(acceleration);
    location.add(velocity);
    //We clear the acceleration
    acceleration.mult(0);
  }

  void draw() {
    //The spaceship will be some certain width and height.
    pushMatrix();
    //We translate to the center of the space ship
    translate(location.x+w/2, location.y+h/2);
    // We rotate the given angle
    rotate(angle);
    rectMode(CENTER);
    fill(255);
    rect(0, 0, w, h);
    imageMode(CENTER);
    image(img,0,0);
    if (burnersApplied) {
      if (frameCount%8>4) {
        fill(255, 0, 0);
        triangle(w/2, h/2, -w/2, h/2, 0, h/2+25);
        fill(255, 128, 0);
        triangle(w/2-2.5, h/2, -w/2+2.5, h/2, 0, h/2+15);
        fill(255, 255, 0);
        triangle(w/2-5, h/2, -w/2+5, h/2, 0, h/2+7.5);
      } else {
        fill(255, 0, 0);
        triangle(w/2, h/2, -w/2, h/2, 0, h/2+20);
        fill(255, 128, 0);
        triangle(w/2-2.5, h/2, -w/2+2.5, h/2, 0, h/2+10);
        fill(255, 255, 0);
        triangle(w/2-5, h/2, -w/2+5, h/2, 0, h/2+5);
      }
    }
    popMatrix();
  }
}
