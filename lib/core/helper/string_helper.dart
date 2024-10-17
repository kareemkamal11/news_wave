extension StringHelper on String {
  String get firstWord {
    return split(' ').first;
  }
  // method to delete first word and return the string without the first word
  String get removeFirstWord {
    return replaceFirst(firstWord, '').trim();
  }
}

