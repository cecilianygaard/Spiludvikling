class StarParticle implements Particle {
  PVector location;
  int alpha;
  int r;
  float t;
  float phaseShift;
  static final int extra = 10000;
  StarParticle(PVector origin) {
    location = new PVector(origin.x+random(-extra, width+extra), origin.y+random(0, height));
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
  int extra = StarParticle.extra;
  StarryBackground(PVector location) {
    super(location);
    for (int i = 0; i < 1000; i++) {
      addParticle();
    }
  }

  void addParticle() {
    particles.add(new StarParticle(origin));
  }
}
