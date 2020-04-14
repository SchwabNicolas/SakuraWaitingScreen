import processing.sound.*;
import java.util.Random;

public Sound sound;
public FFT fft;

public float[] fftArray;
public float[] fftSum;
public float[] scaledSum;
public float smoothFactor = 0.25f;
public float scale = 1;

public PImage background;
public PImage cursor;

public PlayList playList;
public AnimatedText musicDisplay;

public PShape petalShape;
public ParticlePool particlePool;

public PFont fontBig;
public PFont fontSmall;

public float volume = 1;

boolean debug = false;

void settings() {
  fullScreen();
}

// TODO : particle pool
void setup() {
  background = loadImage(dataPath("images") + "\\background.jpg");

  playList = new PlayList(this, sketchPath("musics\\"));

  sound = new Sound(this);

  fft = new FFT(this);
  fftArray = new float[216];
  fftSum = new float[216];
  scaledSum = new float[216];
  volume = 1;

  fontBig = createFont(dataPath("fonts") + "\\Raleway-Regular.ttf", 64);
  fontSmall = createFont(dataPath("fonts") + "\\Raleway-Regular.ttf", 32);

  petalShape = loadShape(dataPath("images") + "\\petal.svg");
  particlePool = new ParticlePool(petalShape);

  cursor = loadImage(dataPath("cursor")+"\\blank.png");
  cursor(cursor);

  playList.playRandom();
}

void draw() {
  fill(255);
  image(background, 0, 0);

  noStroke();

  fft();
  drawFFTAnalysis();

  particlePool.update();

  drawText();

  playList.update();
}

void drawFFTAnalysis() {
  for (int i = 0; i < scaledSum.length; i++) {
    fill(255, 75, 135);
    rect(0, i*5, scaledSum[i], 5 );
    float alpha = scaledSum.length/200*i;
    fill(255, 255, 255, alpha);
    rect(0, i*5, scaledSum[i], 5 );
  }
}

void drawText() {
  textFont(fontBig);
  fill(255, 75, 135);
  String waitingText = "Patience, ça va commencer...";
  text(waitingText, width/2 - textWidth(waitingText) / 2, height - 150);

  if (musicDisplay != null) musicDisplay.update(100, height-25);
  if (playList.changedMusic) {
    musicDisplay = new AnimatedText(playList.musicPlaying.display);
  }
}

void fft() {
  fft.analyze(fftArray);

  for (int i = 0; i < fftArray.length; i++) {
    fftSum[i] += (fftArray[i] - fftSum[i]) * smoothFactor;
    scaledSum[i] = (width - width/20*2) * fftSum[i] * scale;
  }
}

void mouseWheel(MouseEvent event) {
  volume -= event.getCount()/10.0;
  volume = volume <= 0 ? 0 : volume;
  volume = volume >= 1 ? 1 : volume; 
  playList.changeVolume(volume);
}
