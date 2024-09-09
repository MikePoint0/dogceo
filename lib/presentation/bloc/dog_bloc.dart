import 'package:bloc/bloc.dart';
import 'package:dogceo/data/models/dog_breed_model.dart';
import 'package:dogceo/presentation/bloc/dog_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/services/dog_api_service.dart';

part 'dog_event.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  final DogApiService dogApiService;

  DogBloc(this.dogApiService) : super(DogLoadingState()) {
    on<DogFetchEvent>((event, emit) async {
      emit(DogLoadingState());
      try {
        final breeds = await dogApiService.fetchDogBreeds();
        emit(DogLoadedState(breeds));
      } catch (e) {
        emit(DogErrorState(e.toString()));
      }
    });
  }
}