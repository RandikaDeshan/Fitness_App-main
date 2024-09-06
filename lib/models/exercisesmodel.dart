class ExercisesModel {
  final int id;
  final String name;
  final String imageUrl;
  final String description;

  ExercisesModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description});

  factory ExercisesModel.fromJson(Map<String, dynamic> json) {
    return ExercisesModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "description": description,
    };
  }
}
