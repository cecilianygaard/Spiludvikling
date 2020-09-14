class Spaceship{
  float w = 20;
  float h = 20;
  
  
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
  }
  
  void rotateLeft(){
    angle -= 0.1;
  }
  
  void rotateRight(){
    angle += 0.1;
  }
  
  void applyGravity(){ 
    //!!!! THIS SHOULD DEFINITELY NOT BE A MEMBERVARIABLE!!!! AS WE SHOULD USE THE SAME GRAVITY FOR THE PARTICLES OR?
    //WHAT SHOULD GRAVITY BE?
    PVector gravity = new PVector(0,0.0005);
    //!!!!!
    acceleration.add(gravity);
  }
  
  void applyBurners(){
    if(fuel>0) {

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
  

  
  void update(){
     //Gravity will always be applied.
     this.applyGravity();
     //Standard mechanics, thanks NEWTON
     velocity.add(acceleration);
     location.add(velocity);
     //We clear the acceleration
     acceleration.mult(0);
  }

  void draw(){
    //The spaceship will be some certain width and height.
    pushMatrix();
      //We translate to the center of the space ship
      translate(location.x+w/2, location.y+h/2);
      // We rotate the given angle
      rotate(angle);
      rectMode(CENTER);
      rect(0,0,w,h);
      if(burnersApplied) {
      if(frameCount%6>3) {
      triangle(w/2,h/2,-w/2,h/2,0,h/2+25);
      } else {
        triangle(w/2,h/2,-w/2,h/2,0,h/2+20);
      }
      }
    popMatrix();
  }
}
