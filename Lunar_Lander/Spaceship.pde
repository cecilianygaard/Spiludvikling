//This is just the blueprint for the spaceship class DONE
class Spaceship{
  boolean alive = true;
  boolean landed = false;
  
  float w = 20;
  float h = 20;
  PImage img;
  int score;
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

  void reset(){
    //TIME WOULD NEED TO BE RESET AS WELL FOR CALCULATING THE POINTS
    location = new PVector(width/2,0);
    velocity = new PVector(0,0);
    s.landed = false;
  }

  void update() {
    if(!landed && alive){
      //Controls that control rotation and stuff
      if(burnersApplied){
        this.applyBurners();
      }
      if(rotatingLeft){
        this.rotateLeft();
      }
      if(rotatingRight){
        this.rotateRight();
      }
      
      //Gravity will always be applied.
      this.applyGravity();
      //Standard mechanics, thanks NEWTON
      velocity.add(acceleration);
      location.add(velocity);
      //We clear the acceleration
      acceleration.mult(0);
    }else if(!alive){
      println("AHH U DIED");
    }else if(landed){
      println("WUHUUU YOU LANDED SUCCESSFULLY");
      
    }
  }
  
  void draw() {
    //The spaceship will be some certain width and height.
    push();
      //We translate to the center of the space ship
      translate(location.x, location.y);
      // We rotate the given angle
      rotate(angle);
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
    pop();
  }
}
