
import 'package:dogceo/data/models/dog_breed_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class DogState extends Equatable {
  @override
  List<Object> get props => []; // Default props for comparison
}

class DogLoadingState extends DogState {
  @override
  List<Object> get props => []; // No properties, just compare type
}

class DogLoadedState extends DogState {
  final List<DogBreedModel> breeds;

  DogLoadedState(this.breeds);

  @override
  List<Object> get props => [breeds]; // Compare breeds list
}

class DogErrorState extends DogState {
  final String message;

  DogErrorState(this.message);

  @override
  List<Object> get props => [message]; // Compare error message
}
