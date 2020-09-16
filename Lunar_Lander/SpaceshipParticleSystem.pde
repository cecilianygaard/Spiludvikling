class ShipParticle implements Particle {
  PVector origin;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float angle;
  float lifespan;
  int sx, sy, sw, sh;
  PVector[] shape;

  ShipParticle(PVector location_, PVector velocity_, PVector[] shape_) {
    origin = location_.copy();
    location = location_.copy();
    velocity = velocity_.copy();
    shape = shape_;
    angle = random(-4, 4);
  }

  void update() {
    location.add(velocity);
    angle += 0.02;
  }

  void draw() {
    push();
    translate(location.x, location.y);
    rotate(angle);
    stroke(255);
    beginShape();
    for (int i = 0; i < shape.length-1; i++) {
      vertex(shape[i].x, shape[i].y);
      vertex(shape[i+1].x, shape[i+1].y);
    }
    endShape();
    pop();
  }

  void run() {
    update();
    draw();
  }

  Boolean isDead() {
    //We decide whether they should die based on the distance from their current position to their origin.
    return PVector.sub(location, origin).mag()>100;
  }
}

class ShipFragments extends ParticleSystem {
  float w = 20;
  float cell = w/5;
  PVector[][] spaceShapes = { //Main body
                           {new PVector(-0.5*cell, 0.5*cell), 
                            new PVector(0.5*cell, 0.5*cell), 
                            new PVector(1.5*cell, -0.5*cell), 
                            new PVector(1.5*cell, -1.5*cell), 
                            new PVector(0.5*cell, -2.5*cell), 
                            new PVector(-0.5*cell, -2.5*cell), 
                            new PVector(-1.5*cell, -1.5*cell), 
                            new PVector(-1.5*cell, -0.5*cell), 
                            new PVector(-0.5*cell, 0.5*cell)}, 
                            //Burner
                           {new PVector(-0.5*cell, 0.5*cell), 
                            new PVector(0.5*cell, 0.5*cell), 
                            new PVector(1*cell, 2.5*cell), 
                            new PVector(-1*cell, 2.5*cell), 
                            new PVector(-0.5*cell, 0.5*cell)},
                            //Left leg
                           {new PVector(-0.5*cell, 0.5*cell), 
                            new PVector(-2*cell, 2.5*cell),
                            new PVector(-2.5*cell, 2.5*cell),
                            new PVector(-1.5*cell, 2.5*cell)},
                            //Right leg
                           {new PVector(0.5*cell, 0.5*cell), 
                            new PVector(2*cell, 2.5*cell),
                            new PVector(2.5*cell, 2.5*cell),
                            new PVector(1.5*cell, 2.5*cell)}};

  ShipFragments(PVector location) {
    super(location);
    addParticle(0);
    addParticle(1);
    addParticle(2);
    addParticle(3);
  }
  
  void addParticle(int i){
    particles.add(new ShipParticle(origin, new PVector(random(-1, 1), random(-1, -0.3)), spaceShapes[i]));
    
  }
}
