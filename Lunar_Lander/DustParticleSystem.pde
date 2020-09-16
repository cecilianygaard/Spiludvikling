import java.util.Iterator;

class DustParticle implements Particle {
  PVector location;
  PVector velocity;
  PVector origin;
  float lifespan;

  DustParticle(PVector origin_, PVector velocity_) {
    origin = origin_.copy();
    location = origin_.copy();
    velocity = velocity_.copy();
    origin = location.copy();
    lifespan = 255.0;
  }

  void update() {
    location.add(velocity);
    lifespan -= 2;
  }

  void draw() {
    push();
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(location.x, location.y, 1, 1);
    pop();
  }
  
  void run() {
    update();
    draw();
  }

  Boolean isDead() {
    if (lifespan <= 0) {
      return true;
    } else {
      return false;
    }
  }
}

class DustyLanding extends ParticleSystem {
  PVector burnerVector;
  DustyLanding() {
    super(new PVector(0, 0));
  }
  
  void addParticle() {
    PVector v = new PVector(random(-0.4, 0.4), random(-0.2, 0));
    particles.add(new DustParticle(origin, v));
  }
  
  void updateOrigin(float x, float y){
    origin.x = x;
    origin.y = y;
  }
  
  void calculateOrigin(Spaceship s, Surface surf){
    //We get the burnervector.
    PVector loc = s.location.copy();
    burnerVector = PVector.sub(s.location, s.location.copy().add(new PVector(0,-10)));
    burnerVector.rotate(s.angle);
    //That's the burner vector now we just have to calculate its line, meaning the a & b in f(x)=a*x+b
    float aBurner = burnerVector.y/burnerVector.x;
    float bBurner = loc.y - aBurner*loc.x;
    //When we have calculated that we go through each of the points on the surface calculating their a&b to see where they would intersect
    //We have to go through all of the points to be sure we have the one closest to the spaceship so it doesn't spawn it on the wrong side of a mountain.
    //We also have to make sure that where they would intersect is in the right "direction" so as to not spawn it on top of the player.
    
    //Intersection: x= (b2-b1)/(a1-a2)
    //We go through all but the last point as we use the following point in the calculation.
    //ArrayList<PVector> intersectPoints = new ArrayList<PVector>();
    PVector oldVectorFromSpaceshipToIntersect = new PVector(width, height);
    for(int i = 0; i < surf.points.size()-1; i++){
      PVector p1 = surf.points.get(i).copy();
      PVector p2 = surf.points.get(i+1).copy();
      
      float aLine = (p2.y-p1.y)/(p2.x-p1.x);
      float bLine = p1.y - aLine*p1.x;
      
      float xIntersect = (bLine-bBurner)/(aBurner-aLine);
      float yIntersect = aLine*xIntersect + bLine;
      
      PVector vectorFromSpaceshipToIntersect = PVector.sub(new PVector(xIntersect, yIntersect), loc);
      //Okay so we have to ask.
      //Does the vector from the location of the spaceship to this point have the same direction as the burnervector?
      if (vectorFromSpaceshipToIntersect.copy().normalize().equals(burnerVector.copy().normalize())){
        
        //If yes, is the point within p1 and p2.
        boolean withinX = (xIntersect >= p1.x && xIntersect <= p2.x);
        boolean withinY = ((yIntersect >= p1.y && yIntersect <= p2.y) || (yIntersect <= p1.y && yIntersect >= p2.y));
        if (withinX && withinY){
          //If all these are fulfilled we look at the distance if the distance is shorter than the current vector we make it the newOrigin
          if(vectorFromSpaceshipToIntersect.mag() <= oldVectorFromSpaceshipToIntersect.mag()){
            oldVectorFromSpaceshipToIntersect = vectorFromSpaceshipToIntersect;
            origin.x = xIntersect;
            origin.y = yIntersect;
          }
        }
      }
    }
  }
  
  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
}
