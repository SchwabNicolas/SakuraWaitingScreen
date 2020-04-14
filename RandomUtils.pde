import java.util.concurrent.ThreadLocalRandom;
import java.util.List;

public static class RandomUtils {
  private RandomUtils() {
  }

  public static int getRandomElement(List<Music> list, int bound) 
  { 
    // ThreadLocalRandom generate a int type number 
    return ThreadLocalRandom.current().nextInt(list.size()) % bound;
  }
}
