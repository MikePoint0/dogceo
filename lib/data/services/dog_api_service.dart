import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog_breed_model.dart';

class DogApiService {
  static const String breedsUrl = "https://dog.ceo/api/breeds/list/all";

  // Fetches the list of dog breeds from the API
  Future<List<DogBreedModel>> fetchDogBreeds() async {
    try {
      final response = await http.get(Uri.parse(breedsUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final breedsJson = data['message'] as Map<String, dynamic>;
        return DogBreedModel.fromBreedsJson(breedsJson);
      } else {
        throw Exception("Failed to load dog breeds. Server responded with status code ${response.statusCode}.");
      }
    } catch (e) {
      throw Exception("Failed to load dog breeds. Error: $e");
    }
  }

  // Fetches a random image for the breed from the API
  Future<String> fetchRandomImage(String breed) async {
    try {
      final response = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'];
      } else {
        throw Exception("Failed to load image for breed: $breed. Server responded with status code ${response.statusCode}.");
      }
    } catch (e) {
      throw Exception("Failed to load image for breed: $breed. Error: $e");
    }
  }
}