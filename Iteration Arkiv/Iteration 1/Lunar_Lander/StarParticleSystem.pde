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
  push();
  stroke(0);
  fill(175);
  ellipse(location.x,location.y,r,r);
  pop();
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
