class StarParticle implements Particle {
  PVector location;
  int alpha;
  int r;
  float t;
  float phaseShift;

  StarParticle() {
    location = new PVector(random(0, width), random(0, height));
    alpha = int(random(100, 255));
    r = int(random(2, 5));
    phaseShift = random(-4, 4);
  }

  void update() {
    t += 0.03;
    t = t%(2*PI);
  }

  void draw() {
    push();
    stroke(0);
    fill(255, alpha);
    circle(location.x, location.y, r+(r/2*sin(t+phaseShift)));
    pop();
  }

  void run() {
    update();
    draw();
  }

  Boolean isDead() {
    return false;
  }
}

class StarryBackground extends ParticleSystem {
  StarryBackground(PVector location) {
    super(location);
    for (int i = 0; i < 200; i++) {
      addParticle();
    }
  }

  void addParticle() {
    particles.add(new StarParticle());
  }
}
