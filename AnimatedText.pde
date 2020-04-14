class AnimatedText {
  String text;
  String modifiedText;
  int currentLetter;
  int lastChangeMillis;
  int timePerLetter;
  int timePerChar;
  int lastCharMillis;

  public AnimatedText(String text) {
    this.text = text;
    timePerLetter = 75;
    timePerChar = 25;
    lastChangeMillis = millis();
    lastCharMillis = millis();
    modifiedText = "";
  }

  void update(int x, int y) {
    textFont(fontSmall);

    if (currentLetter <= text.length() && currentLetter != -1) {
      //if (millis()-currentLetter*timePerLetter >= timePerLetter) {
      if (millis() - lastChangeMillis >= timePerLetter) {
        String tempText = "";
        for (int i = 0; i < currentLetter-1; i++) {
          tempText += text.charAt(i);
        }
        if (currentLetter > 0) {
          tempText += text.charAt(currentLetter-1);
        }
        modifiedText = tempText;
        if (currentLetter < text.length()) {
          currentLetter++;
        } else {
          currentLetter = -1;
        }
        lastChangeMillis = millis();
      }

      if (millis() - lastCharMillis >= timePerChar) {
        String obfuscatedText = "";
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890éèêáàâíìîóòôõ$£{}[]!¨ëäïö¦@#°§¬|¢´~+`*ç%&/()=?/<>§°,;.:-_¥⅕⅙⅛⅔⅖⅗⅘⅜⅚⅐⅝↉⅓⅑⅒⅞«»®©™¢€";
        int rnd = (int)random(0, chars.length());
        for (int i = 0; i < currentLetter-1; i++) {
          obfuscatedText += text.charAt(i);
        }
        obfuscatedText += chars.charAt(rnd);
        modifiedText = obfuscatedText;
        lastCharMillis = millis();
      }
      text(modifiedText, x, y);
    } else {
      text(text, x, y);
    }
  }
}
