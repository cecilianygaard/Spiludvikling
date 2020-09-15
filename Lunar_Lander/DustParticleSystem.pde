import java.util.Iterator;

class DustParticle implements Particle{
  PVector location;
  PVector velocity;
  PVector origin;
  float lifespan;
  
  DustParticle(PVector origin_, PVector velocity_){
  origin = origin_.copy();
  location = origin_.copy();
  velocity = velocity_.copy();
  origin = location.copy();
  lifespan = 255.0;
}

  void update(){
  location.add(velocity);
  lifespan -= 2;
}

  void draw(){
  push();
  stroke(255,lifespan);
  fill(255,lifespan);
  ellipse(location.x,location.y,1,1);
  pop();
  }
  void run(){
  update();
  draw();
  }
  
  Boolean isDead(){
    if(lifespan <= 0){
    return true;
  } else {
    return false;
    }
  }
}

class DustyLanding extends ParticleSystem{
  DustyLanding(PVector location){
    super(location);
  }
   void addParticle(){
     PVector v = new PVector(random(-0.4,0.4),random(-0.2,0));
    particles.add(new DustParticle(origin, v));
   }
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
