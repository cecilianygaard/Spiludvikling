class ShipParticle implements Particle{
  PVector origin;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int sx,sy,sw,sh;
  PImage img;
  
  ShipParticle(PVector location_,PVector velocity_,int sx_,int sy_,int sw_,int sh_){
    origin = location_.copy();
    location = location_.copy();
    velocity = velocity_.copy();
    img = loadImage("Spaceship.png");
    sx = sx_;
    sy = sy_;
    sw = sw_;
    sh = sh_;
  }
  void update(){
    location.add(velocity);
  }
  void draw(){
    //rect(location.x, location.y, sw, sh);
    image(img,location.x,location.y,sw,sh,sx,sy,20,20);
  }
  void run(){
    update();
    draw();
  }
  Boolean isDead(){
    //We decide whether they should die based on the distance from their current position to their origin.
    return PVector.sub(location, origin).mag()>100;
  }
}

class ShipFragments extends ParticleSystem{
  ShipFragments(PVector location){
    super(location);
    addParticle(0,0);
    addParticle(1,0);
    addParticle(0,1);
    addParticle(1,1);
  }
  
  void addParticle(int col, int row){
    particles.add(new ShipParticle(origin, new PVector(random(-1,1),random(-1,-0.3)), 10*col, 10*row, 10, 10));
  }
}
