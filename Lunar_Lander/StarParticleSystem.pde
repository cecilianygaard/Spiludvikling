class StarParticle implements Particle {
  PVector location;
  int alpha;
  int r;
  float t;

  StarParticle() {
    location = new PVector(random(0, width), random(0, height));
    alpha = int(random(100, 255));
    r = int(random(2, 10));
  }

  void update() {
    t += 0.05;
    t = t%(2*PI);
  }

  void draw() {
    push();
    stroke(0);
    fill(255, alpha);
    circle(location.x, location.y, r+sin(t));
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
    for (int i = 0; i < 100; i++) {
      addParticle();
    }
  }

  void addParticle() {
    particles.add(new StarParticle());
  }
}
