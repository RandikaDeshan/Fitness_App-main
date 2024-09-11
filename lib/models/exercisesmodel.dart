class ExercisesModel {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String userId;
  final String category;

  ExercisesModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.userId,
      required this.category});

  factory ExercisesModel.fromJson(Map<String, dynamic> json) {
    return ExercisesModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        userId: json["userId"],
        category: json["category"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "description": description,
      "userId": userId,
      "category": category
    };
  }
}
