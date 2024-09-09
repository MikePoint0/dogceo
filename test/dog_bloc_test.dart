import 'package:dogceo/data/models/dog_breed_model.dart';
import 'package:dogceo/data/services/dog_api_service.dart';
import 'package:dogceo/presentation/bloc/dog_bloc.dart';
import 'package:dogceo/presentation/bloc/dog_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'dog_api_service_test.mocks.dart';

@GenerateMocks([DogApiService])

void main() {
  late MockDogApiService mockDogApiService;
  late DogBloc dogBloc;

  setUp(() {
    mockDogApiService = MockDogApiService();
    dogBloc = DogBloc(mockDogApiService);
  });

  group('DogBloc', () {
    test('initial state should be DogLoadingState', () {
      expect(dogBloc.state, equals(DogLoadingState()));
    });

    blocTest<DogBloc, DogState>(
      'should emit [DogLoadingState, DogLoadedState] when DogFetchEvent is added',
      build: () {
        // Return a mock list of dog breeds
        when(mockDogApiService.fetchDogBreeds()).thenAnswer((_) async => [
          DogBreedModel(breed: 'akita', subBreeds: ['japanese']),
          DogBreedModel(breed: 'beagle', subBreeds: [])
        ]);
        return dogBloc;
      },
      act: (bloc) => bloc.add(DogFetchEvent()),
      expect: () => [DogLoadingState(), isA<DogLoadedState>()],
    );

    blocTest<DogBloc, DogState>(
      'should emit [DogLoadingState, DogErrorState] when API call fails',
      build: () {
        // Simulate an exception being thrown
        when(mockDogApiService.fetchDogBreeds()).thenThrow(Exception('Failed to load breeds'));
        return dogBloc;
      },
      act: (bloc) => bloc.add(DogFetchEvent()),
      expect: () => [DogLoadingState(), isA<DogErrorState>()],
    );
  });
}

