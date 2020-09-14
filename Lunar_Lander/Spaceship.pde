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
  float angle = 0;
  
  //YEAH THIS SHOULD ALSO BE CALLIBRATED
  float burnerPower = 5;
  float fuel;
  
  //WHAT SHALL BE INITIALIZED?
  Spaceship(){
    location = new PVector(width/2,0);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    img = loadImage("Spaceship.png");
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
    PVector gravity = new PVector(0,0.01);
    //!!!!!
    acceleration.add(gravity);
  }
  
  void applyBurners(){
    //WE NEED TO CALCULATE THE BURNERFORCE'S DIRECTION FROM THE ROTATION
    PVector burnerForce = new PVector();
    
    //WE NEED TO DECREASE THE AMOUNT OF FUEL AS WELL
    acceleration.add(burnerForce);
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
      rect(0,0,h,w);
      imageMode(CENTER);
      image(img,0,0);
    popMatrix();
  }
}
