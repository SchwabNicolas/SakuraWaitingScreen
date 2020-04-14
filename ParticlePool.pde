public class ParticlePool {
  public ArrayList<Particle> particles;
  public ArrayList<Particle> recycler;
  public PShape shape;
  public int maxParticleNumber = 100;

  public ParticlePool(PShape shape) {
    particles = new ArrayList<Particle>();
    recycler = new ArrayList<Particle>();
    this.shape = shape;
  }

  public void update() {
    pushMatrix();
    for (Particle p : particles) {
      p.update();
      p.display();
    }
    popMatrix();

    if (frameCount%12 == 0 && particles.size() < maxParticleNumber) {
      float xOryBased = random(100);
      if (xOryBased <= 50) {
        particles.add(getParticle(width+100, random(0, height)));
      } else {
        particles.add(getParticle(random(0, width), -100));
      }
    }

    for (int i = 0; i < particles.size(); i++) {
      if (particles.get(i).needRecycle) {
        recycler.add(particles.get(i));
        particles.remove(i);
      }
    }
  }

  public Particle getParticle(float x, float y) {
    if (recycler.size() == 0) { 
      return new Particle(x, y);
    }

    Particle recycledParticle = recycler.get(0);
    recycler.remove(0);
    recycledParticle.reset(x, y);
    return recycledParticle;
  }
}
