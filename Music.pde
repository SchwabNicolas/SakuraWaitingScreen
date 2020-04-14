class Music {
  public SoundFile soundFile;
  public String display;
  public color palette;
  public String colorValueChanging;

  public Music(PApplet pApplet, String soundFilePath, String display) {
    soundFile = new SoundFile(pApplet, soundFilePath);
    this.display = display;
  }

  public SoundFile getSoundFile() {
    return soundFile;
  }
}
