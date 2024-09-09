import 'package:dogceo/presentation/bloc/dog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:dogceo/presentation/pages/main_page.dart';
import 'package:dogceo/presentation/bloc/dog_bloc.dart';
import 'package:dogceo/data/models/dog_breed_model.dart';

// Mock DogBloc
class MockDogBloc extends Mock implements DogBloc {
  @override
  Stream<DogState> get stream => Stream<DogState>.empty(); // Default stream
}

void main() {
  testWidgets('accordion expands and collapses correctly', (WidgetTester tester) async {
    // Create a mock DogBloc
    final mockDogBloc = MockDogBloc();

    setUp(() {
      when(mockDogBloc.state).thenReturn(DogLoadedState([
        DogBreedModel(breed: 'akita', subBreeds: []),
        DogBreedModel(breed: 'beagle', subBreeds: [])
      ]));

      // Set up the stream to emit a DogLoadedState
      when(mockDogBloc.stream).thenAnswer((_) => Stream<DogState>.fromIterable([
        DogLoadedState([
          DogBreedModel(breed: 'akita', subBreeds: []),
          DogBreedModel(breed: 'beagle', subBreeds: [])
        ])
      ]));
    });
    // Prepare mock behavior: emit DogLoadedState with mock breeds


    // Wrap the MainPage widget with BlocProvider and ScreenUtilInit
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              BlocProvider<DogBloc>(
                create: (context) => mockDogBloc, // Provide the mock DogBloc
              ),
            ],
            child: MaterialApp(
              home: MainPage(),
            ),
          );
        },
      ),
    );

    // Verify the ExpansionTile is present
    expect(find.byType(ExpansionTile), findsWidgets);

    // Tap on the first expansion tile
    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pumpAndSettle(); // Wait for the animation to complete

    // Ensure it expanded (this assumes the text "No sub-breeds" is shown)
    expect(find.text('No sub-breeds'), findsOneWidget);

    // Tap again to collapse
    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pumpAndSettle();

    // Ensure it's collapsed
    expect(find.text('No sub-breeds'), findsNothing);
  });
}