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
