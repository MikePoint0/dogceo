class DogBreedModel {
  final String breed;
  final List<String> subBreeds;

  DogBreedModel({required this.breed, required this.subBreeds});

  factory DogBreedModel.fromJson(Map<String, dynamic> json) {
    return DogBreedModel(
      breed: json['breed'],
      subBreeds: List<String>.from(json['subBreeds']),
    );
  }

  static List<DogBreedModel> fromBreedsJson(Map<String, dynamic> breedsJson) {
    return breedsJson.entries
        .map((entry) => DogBreedModel(
        breed: entry.key,
        subBreeds: List<String>.from(entry.value as List)))
        .toList();
  }
}