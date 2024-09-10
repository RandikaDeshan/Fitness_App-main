class ExercisesModel {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String userId;

  ExercisesModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.userId});

  factory ExercisesModel.fromJson(Map<String, dynamic> json) {
    return ExercisesModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        userId: json["userId"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "description": description,
      "userId": userId
    };
  }
}
