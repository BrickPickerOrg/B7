class PlayerUtils {
  static String formatSingersName(singers) {
    return singers.map((singer) => singer['name']).toList().join('/');
  }
}
