import 'package:dogceo/utils/string_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('capitalizeWords capitalizes the first letter of each word', () {
    // Arrange
    const input = 'akita dog breed';
    const expectedOutput = 'Akita Dog Breed';

    // Act
    final result = capitalizeWords(input);

    // Assert
    expect(result, expectedOutput);
  });
}
