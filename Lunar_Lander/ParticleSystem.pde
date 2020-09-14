import java.util.Iterator;

interface Particle{
  void update();
  void draw();
  void run();
  Boolean isDead();
}

class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector location){
    origin = location.copy();
    particles = new ArrayList<Particle>();
  }
  //WE WOULD NEED TO IMPLEMENT THIS ANEW FOR EACH ACTUAL PARTICLESYSTEM
  void addParticle(){}
  
  void run(){
    Iterator<Particle> it = particles.iterator();
    while(it.hasNext()){
      Particle p = it.next();
      p.run();
      if(p.isDead()){
        it.remove();
      }
    } 
  } 
}
class StarParticle implements Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  int r;
  
  StarParticle(){
  location = new PVector(random(0,width),random(0,height));
  velocity = new PVector(0,0);
  acceleration = new PVector(0,0);
  r = int(random(1,10));
}
  void update(){
  velocity.add(acceleration);
  location.add(velocity);
}
  void draw(){
  stroke(0);
  fill(175);
  ellipse(location.x,location.y,r,r);
  }
  void run(){
  update();
  draw();
  }
  Boolean isDead(){
    return false;
  }
}

class StarryBackground extends ParticleSystem{
  StarryBackground(PVector location){
    super(location);
    for (int i = 0; i < 100; i++){
      addParticle();
    }
  }
  void addParticle(){
  particles.add(new StarParticle());
  }
}
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
