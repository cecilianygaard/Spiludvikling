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
