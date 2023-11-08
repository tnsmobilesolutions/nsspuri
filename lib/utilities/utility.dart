class Utility {
  static String convertToCamelCase(String input) {
    // Split the input text by whitespace or underscores
    List<String> words = input.split(RegExp(r'\s+|_'));

    if (words.isNotEmpty) {
      // Capitalize the first letter of each word except the first one
      for (int i = 1; i < words.length; i++) {
        words[i] = ' ' + words[i][0].toUpperCase() + words[i].substring(1);
      }

      // Join the words to form the camel case string
      return words.join('');
    } else {
      // If no spaces or underscores, return the original input
      return input;
    }
  }
}
