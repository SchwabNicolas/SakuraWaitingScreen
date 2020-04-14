class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;

  PVector target;

  float maxforce;
  float maxspeed;

  int maxRotation;
  int angle;
  int rotation;

  boolean needRecycle = false;

  PShape shape;

  Particle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    this.location = new PVector(x, y);
    this.target = new PVector(-width, height*2);
    maxspeed = 6;
    maxforce = 0.1;
    shape = petalShape;
    maxRotation = 180;
    angle = (int)random(1,3);
  }

  void reset(float x, float y) {
    acceleration = acceleration.set(0, 0);
    velocity = velocity.set(0,0);
    this.location = location.set(x, y);
    angle = (int)random(1, 3);
    needRecycle = false;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    checkBoundaries();
    seek();
  }

  void checkBoundaries() {
    needRecycle = location.x <= -shape.width || location.y >= height+shape.height;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void seek() {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void display() {
    noStroke();

    shape.resetMatrix();
    rotation += angle;
    if(rotation > 360) {
      rotation = 0;
    }
    shape.rotate(radians(rotation));
    shape(shape, location.x, location.y, shape.width/4, shape.height/4);

    if (debug) displayDebug();
  }

  void displayDebug() {
    stroke(255, 0, 0);
    strokeWeight(2);
    line(location.x, location.y, target.x, target.y);
    noStroke();
  }
}
