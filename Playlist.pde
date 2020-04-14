public enum Modes {
  LINEAR, 
    RANDOM
}

public class PlayList {

  public Music musicPlaying;
  public int musicPlayingIndex;
  public ArrayList<Music> musics;
  public String[] musicPaths;
  public boolean playing;
  public Modes mode;
  public ArrayList<Integer> playedMusicIndexes;
  public boolean changedMusic;

  public PlayList(PApplet pApplet, String folder) {
    musicPaths = FileUtils.listFileNames(folder);

    musics = new ArrayList<Music>();
    for (int i = 0; i < musicPaths.length; i++) {
      String[] splitName = split(musicPaths[i], '.');
      musics.add(new Music(pApplet, sketchPath("musics\\") + musicPaths[i], splitName[0]));
    }

    playedMusicIndexes = new ArrayList<Integer>();
  }

  public void update() {
    changedMusic = false;
    if (playing) {
      if (!musicPlaying.soundFile.isPlaying()) next();
    }
  }

  public void next() {
    switch(mode) {
    case RANDOM:
      play(getRandomMusic());
      break;
    case LINEAR:

      break;
    }
  }

  private void play(int musicIndex) {
    playing = true;
    playedMusicIndexes.add(musicIndex);
    musicPlaying = musics.get(musicIndex);
    musicPlaying.soundFile.play();
    fft.input(musicPlaying.getSoundFile());
    changedMusic = true;
  }

  public int getRandomMusic() {
    if (playedMusicIndexes.size() >= musics.size()) {
      playedMusicIndexes.clear();
      return getRandomMusic();
    }

    int rndElement = RandomUtils.getRandomElement(musics, musics.size());
    if (hasBeenPlayed(rndElement)) return getRandomMusic();
    return rndElement;
  }

  public boolean hasBeenPlayed(int index) {
    for (int i = 0; i < playedMusicIndexes.size(); i++) {
      if (index == playedMusicIndexes.get(i)) return true;
    }
    return false;
  }

  public void playRandom() {
    mode = Modes.RANDOM;
    next();
  }

  public void changeVolume(float volume) {
    for (int i = 0; i < musics.size(); i++) {
      musics.get(i).soundFile.amp(volume);
    }
  }
}
