import 'package:dogceo/data/models/dog_breed_model.dart';
import 'package:dogceo/data/services/dog_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dog_api_service_test.mocks.dart';
@GenerateMocks([DogApiService])

void main() {
  late MockDogApiService mockDogApiService;
  setUp(() {
    mockDogApiService = MockDogApiService();
  });

  group('DogApiService', () {
    test('should return a list of dog breeds when fetchDogBreeds is called', () async {
      // Arrange
      final List<DogBreedModel> mockBreeds = [
        DogBreedModel(breed: 'akita', subBreeds: ['japanese']),
        DogBreedModel(breed: 'beagle', subBreeds: [])
      ];

      when(mockDogApiService.fetchDogBreeds()).thenAnswer((_) async => mockBreeds);

      // Act
      final result = await mockDogApiService.fetchDogBreeds();

      // Assert
      expect(result, isA<List<DogBreedModel>>());
      expect(result.length, 2);
      expect(result.first.breed, 'akita');
    });

    test('should throw an exception when the API call fails', () async {
      // Arrange
      when(mockDogApiService.fetchDogBreeds()).thenThrow(Exception('Failed to fetch breeds'));

      // Act
      expect(() async => await mockDogApiService.fetchDogBreeds(), throwsException);
    });
  });
}
