// utils/string_utils.dart
String capitalizeWords(String input) {
  return input
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}
